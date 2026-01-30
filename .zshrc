# Standalone ZSH Configuration
# Based on Oh My Zsh setup but works without OMZ installation

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY           # Append to history file
setopt SHARE_HISTORY            # Share history across terminals
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt HIST_IGNORE_SPACE        # Don't record commands starting with space
setopt HIST_VERIFY              # Show command with history expansion before running
setopt INC_APPEND_HISTORY       # Add commands immediately to history

# ============================================================================
# ZSH OPTIONS
# ============================================================================
setopt AUTO_CD                  # cd by typing directory name if it's not a command
setopt AUTO_PUSHD               # Make cd push old directory to stack
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT             # Don't print directory stack after pushd/popd
setopt CORRECT                  # Spelling correction
setopt EXTENDED_GLOB            # Extended globbing
setopt NO_BEEP                  # Don't beep on errors
setopt INTERACTIVE_COMMENTS     # Allow comments in interactive shell

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menu selection for completion
zstyle ':completion:*' menu select

# Colorful completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Cache completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Improved directory completion
zstyle ':completion:*' squeeze-slashes true

# Process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source $HOME/Config-Files/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ============================================================================
# KEY BINDINGS
# ============================================================================
# Use vim keybindings
# bindkey -v
#export KEYTIMEOUT=1

# Show vi mode in prompt
# function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%} [NORMAL]%{$reset_color%}"
#    PROMPT='${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}%{$fg[green]%}➜ %{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}${vcs_info_msg_0_} '
    #zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# Better history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow
bindkey "^P" up-line-or-beginning-search      # Ctrl+P
bindkey "^N" down-line-or-beginning-search    # Ctrl+N

# Home/End keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Delete key
bindkey "^[[3~" delete-char

# Ctrl+arrow keys for word navigation
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Ctrl + Backspace to delete previous word
bindkey '^H' backward-kill-word

# Ctrl + Delete to delete next word
bindkey '^[[3;5~' kill-word

# makes Ctrl + backspace/delete a bit more natural
autoload -U select-word-style
select-word-style bash

# Removes common delimiters from WORDCHARS to mimic Bash
WORDCHARS=${WORDCHARS//[\/.\-]}

# ============================================================================
# PROMPT CONFIGURATION
# ============================================================================
# Enable parameter expansion, command substitution and arithmetic expansion
setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1 # Diable the default python prompt change

#colours
autoload -U colors && colors

# Load version control info
autoload -Uz vcs_info
precmd() { 
  if [[ "$PWD" =~ ^/mnt/ ]]; then 
    zstyle ':vcs_info:*' check-for-changes false
  else
    zstyle ':vcs_info:*' check-for-changes true
  fi
  vcs_info
}

# Configure vcs_info for git
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}X%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}X%f'
zstyle ':vcs_info:git:*' formats ' %F{cyan}git:(%F{red}%b%F{cyan})%f%u%c'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}git:(%F{red}%b|%a%F{cyan})%f%u%c'

# Robbyrussell theme prompt
# Format: ➜  directory git:(branch) ✗
PROMPT='$(virtualenv_info) %{$fg[green]%}> %{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}${vcs_info_msg_0_} '

# Right prompt is empty in robbyrussell theme
#RPROMPT=''

# Syntax highlighting
source $HOME/Config-Files/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ============================================================================
# ALIASES
# ============================================================================

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# List directory contents
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'
alias lt='ls -lhtr'  # Sort by date, most recent last

# Safer file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Show open ports
alias ports='netstat -tulanp'

# Process management
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Disk usage
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h'

# Git aliases (commonly used ones from Oh My Zsh)
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Docker aliases (if you use Docker)
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'

# Python aliases
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv .venv'
alias activate='source  .venv/bin/activate'

# Quick edits
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias zshreload='source ~/.zshrc'

# System info
alias myip='curl -s ifconfig.me'

# tmux
alias tns="tmux new -s"
alias tks="tmux kill-session -t"
alias tksv="tmux kill-server"
alias tls="tmux list-sessions"
alias tas="tmux attach-session -t" 

# fzf
alias fz="fzf"
alias nv="nvim"

# ip colours
alias ip="ip -c"

# ============================================================================
# FUNCTIONS (Plugin-like functionality)
# ============================================================================

# Extract archives - replaces extract plugin
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.tar.xz)    tar xf "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find in files
fif() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: fif <search_term> <directory>"
        return 1
    fi
    grep -rnw "$2" -e "$1"
}

# Quick find
qfind() {
    find . -iname "*$1*"
}

# Create backup of a file
backup() {
    if [ -f "$1" ]; then
        cp "$1" "${1}.backup-$(date +%Y%m%d-%H%M%S)"
    else
        echo "File not found: $1"
    fi
}

# Print directory tree (limited depth)
tree() {
    if command -v tree &> /dev/null; then
        command tree "$@"
    else
        find "${1:-.}" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
    fi
}

# venv prompt check
function virtualenv_info {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "($(basename "$VIRTUAL_ENV")) "
    fi
}

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# Default editor
export EDITOR='vim'
export VISUAL='vim'

# Less options
export LESS='-R -i -M -F -X'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# PATH additions (adjust as needed)
# export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ============================================================================
# CUSTOM ADDITIONS
# ============================================================================

# Source local customizations if they exist
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top --style minimal --preview "fzf-pre    view.sh {}" --bind "focus:transform-header:file --brief {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Auto-start or attach to tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Try to attach to existing session, or create new one
    tmux attach-session -t 0 || tmux new-session -s 0
fi

