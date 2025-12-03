#!/bin/bash

set -e # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

installmissing=false
onKali=false
while getopts ":ik" opt; do
  case $opt in
  i) installmissing=true ;;
  k) onKali=true ;;
  \?)
    echo -e "${RED}Invalid option: -$OPTARG${NC}" >&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

# Helper functions
log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Backup existing file/link if it exists
backup_if_exists() {
  local file="$1"
  if [ -e "$file" ] || [ -L "$file" ]; then
    local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    log_warn "Backing up existing $file to $backup"
    mv "$file" "$backup"
  fi
}

# Create symlink with validation
create_symlink() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    log_error "Source file does not exist: $source"
    return 1
  fi

  # Create target directory if needed
  local target_dir=$(dirname "$target")
  if [ ! -d "$target_dir" ]; then
    log_info "Creating directory: $target_dir"
    mkdir -p "$target_dir"
  fi

  backup_if_exists "$target"

  ln -s "$source" "$target"
  if [ -L "$target" ]; then
    log_info "Created symlink: $target -> $source"
  else
    log_error "Failed to create symlink: $target"
    return 1
  fi
}

# Clone or update git repository
clone_or_update() {
  local repo="$1"
  local dest="$2"

  if [ -d "$dest/.git" ]; then
    log_info "Updating existing repository: $dest"
    git -C "$dest" pull
  else
    if [ -d "$dest" ]; then
      log_warn "Directory exists but is not a git repo, removing: $dest"
      rm -rf "$dest"
    fi
    log_info "Cloning repository: $repo"
    git clone "$repo" "$dest"
  fi
}

if $installmissing; then
  log_info "Installing missing dependencies..."

  # Install fzf
  if ! command -v fzf &>/dev/null; then
    log_info "Installing fzf..."
    if [ -d ~/.fzf ]; then
      log_info "fzf directory exists, updating..."
      cd ~/.fzf && git pull && ./install --all
    else
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install --all
    fi
  else
    log_info "fzf already installed, skipping"
  fi

  # Install neovim
  if ! command -v nvim &>/dev/null; then
    log_info "Installing neovim..."

    # Detect OS
    NVIM_FILE="nvim-linux-x86_64.tar.gz"
    NVIM_DIR="nvim-linux-x86_64"

    curl -LO "https://github.com/neovim/neovim/releases/download/nightly/${NVIM_FILE}"
    sudo rm -rf "/opt/${NVIM_DIR}"
    sudo tar -C /opt -xzf "${NVIM_FILE}"
    sudo ln -sf "/opt/${NVIM_DIR}/bin/nvim" /usr/local/bin/nvim
    rm "${NVIM_FILE}"
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log_info "Neovim installed successfully"
  else
    log_info "neovim already installed, skipping"
  fi
fi

log_info "Installing ZSH plugins..."
mkdir -p "$HOME/Config-Files/plugins"
clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/Config-Files/plugins/zsh-syntax-highlighting"
clone_or_update "https://github.com/zsh-users/zsh-autosuggestions.git" "$HOME/Config-Files/plugins/zsh-autosuggestions"

log_info "Installing Tmux Plugin Manager..."
mkdir -p "$HOME/.tmux/plugins"
clone_or_update "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

# Link config files
log_info "Installing config files..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create symlinks for config files
create_symlink "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$SCRIPT_DIR/.config/nvim/" "$HOME/.config/nvim/"

# Use kali zsh if on Kali, otherwise use regular zshrc
if $onKali; then
  log_info "Using Kali-specific zshrc"
  create_symlink "$SCRIPT_DIR/.kali_zshrc" "$HOME/.zshrc"
else
  create_symlink "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
fi

log_info ""
log_info "Installation complete!"
echo -e "\n${YELLOW}TODO:${NC}"
echo "  - Press Ctrl+a then I in tmux to install plugins"
echo "  - Restart your shell or run: source ~/.zshrc"
echo ""
log_info "Done!"
