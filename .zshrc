# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
		zsh-syntax-highlighting
		zsh-autosuggestions
       	colorize
		catimg
		colored-man-pages
		)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias tns="tmux new -s"
alias tks="tmux kill-session -t"
alias tksv="tmux kill-server"
alias tls="tmux list-sessions"
alias tas="tmux attach-session -t" 
alias mi="micro"
alias fz="fzf"
#alias xclip="xclip -sel clip"

# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top --style minimal --preview "fzf-preview.sh {}" --bind "focus:transform-header:file --brief {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Uncomment If fzf keybinds dont work (e.g. Ctrl-T, Ctrl-R)
#source /usr/share/doc/fzf/examples/key-bindings.zsh
#source /usr/share/doc/fzf/examples/completion.zsh

#sothat tmux and zsh agree (heplps with copy/paste)
if [[ -n $TMUX ]]; then
  export TERM="tmux-256color"
else
  export TERM="xterm-256color"
fi



export MICRO_TRUECOLOR=1
