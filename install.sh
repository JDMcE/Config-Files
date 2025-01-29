#!/bin/bash

echo "Installing OhMyZsh plugins ..."

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


echo "Installing Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm


echo "Installing micro theme ..."
git clone https://github.com/dracula/micro.git

if [ ! -d "$HOME/.config/micro/colorschemes/" ]; then
  mkdir $HOME/.config/micro/colorschemes/
fi

ln -s $HOME/Config-Files/micro/dracula.micro $HOME/.config/micro/colorschemes/dracula.micro


echo "Installing config files ..."
ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -s $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/Config-Files/.vimrc $HOME/.vimrc


echo "Done"
echo "^a-I in tmux to install plugins"
