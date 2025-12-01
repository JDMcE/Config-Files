#!/bin/bash

installmissing=false
onKali=false
while getopts ":ik" opt; do
  case $opt in
    i) installmissing=true ;;
    k) onKali=true ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))


if $installmissing; then
	# Install fzf
	if ! command -v fzf 2>&1 >/dev/null; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install
	fi

    # Install neovim
    if ! command -v nvim 2>&1 >/dev/null; then
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz
        sudo rm -rf /opt/nvim-linux-x86_64
        sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
        ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    fi
fi

echo "Installing ZSH plugins ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/Config-Files/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/Config-Files/plugins/zsh-autosuggestions


echo "Installing Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Link files
echo "Installing config files ..."
ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -sf $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/Config-Files/.vimrc $HOME/.vimrc
ln -sf $HOME/Config-Files/.config/nvim/init.lua $HOME/.config/nvim/init.lua

# Use kali zsh since OhMyZsh usually isnt installed
if $onKali; then
	ln -sf $HOME/Config-Files/.kali_zshrc $HOME/.zshrc
fi


echo -e "\n\nTODO:"
echo "^a-I in tmux to install plugins"
echo "Done :)"
