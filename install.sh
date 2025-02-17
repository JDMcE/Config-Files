#!/bin/bash

installmissing=false
onKali=false
while getopts ":ikh" opt; do
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

	#Install micro
	if ! command -v micro 2>&1 >/dev/null; then
		sudo apt -y install micro
	fi
fi


echo "Installing OhMyZsh plugins ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


echo "Installing Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Micro colorscheme
echo "Micro setup ..."
if [ ! -d "$HOME/.config/micro/colorschemes/" ]; then
  mkdir -p $HOME/.config/micro/colorschemes/
fi
ln -sf $HOME/Config-Files/micro/dracula.micro $HOME/.config/micro/colorschemes/dracula.micro
ln -sf $HOME/Config-Files/micro/bindings.json $HOME/.config/micro/bindings.json
ln -sf $HOME/Config-Files/micro/settings.json $HOME/.config/micro/settings.json

# Link files
echo "Installing config files ..."
ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -sf $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/Config-Files/.vimrc $HOME/.vimrc

# Use kali zsh since OhMyZsh usually isnt installed
if $onKali; then
	echo """
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


export MICRO_TRUECOLOR=1
""" >> $HOME/.zshrc
fi


echo -e "\n\nTODO:"
echo "^a-I in tmux to install plugins"
echo "Done :)"
