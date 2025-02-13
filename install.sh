#!/bin/bash

installmissing=false
while getopts ":i" opt; do
  case $opt in
    i) installmissing=true ;;
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
echo "Installing micro theme ..."
git clone https://github.com/dracula/micro.git

if [ ! -d "$HOME/.config/micro/colorschemes/" ]; then
  mkdir -p $HOME/.config/micro/colorschemes/
fi
ln -s $HOME/Config-Files/micro/dracula.micro $HOME/.config/micro/colorschemes/dracula.micro

# Link files
echo "Installing config files ..."
ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -s $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/Config-Files/.vimrc $HOME/.vimrc


echo -e "\n\nTODO:"
echo "^a-I in tmux to install plugins"
echo "^e -> 'set colorscheme dracula' in micro"
echo "Done :)"
