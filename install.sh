#!/bin/bash

echo "Installing config files"

ln -s $HOME/Config-Files/.zshrc $HOME/.zshrc
ln -s $HOME/Config-Files/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/Config-Files/.vimrc $HOME/.vimrc

echo "Done"
