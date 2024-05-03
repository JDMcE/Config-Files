#!/bin/bash

echo "Installing plugins ..."

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing config files ..."

ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -s $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/Config-Files/.vimrc $HOME/.vimrc

echo "Done"
