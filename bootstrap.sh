#!/bin/bash

#
# Bootstrap for setting remote development environments.
# Version 0.0.1

echo "************************************************"
echo "*         Dotfiles bootstrap file (Development)"
echo "*         Version: 0.0.1"
echo "*         Author: Jose Vidal"
echo "*         License: MIT"
echo "************************************************"

# Install required applications.
echo "1) Installing main libraries: Vim, Tmux and Ruby..."
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install rubygems
sudo apt-get install ruby1.9.3
sudo apt-get install exuberant-ctags 

# Install required gems.
echo "2) Fetching gems: Tmuxinator..."
sudo gem install tmuxinator

# Setup configurations.
echo "3) Configuring .dotfiles and settings."
if [ -d .vim/.vimrc ]
then
    echo "* VIM: Install Vim folder (plugins, scripts...) in ~/ ..."
    # Copy vim folder into the user directory.
    cp -rf .vim/ ~/.vim
    echo "* VIM: Create symbolic link of .vimrc"
    # Create symbolic link of .vimrc.
    sudo ln -s ~/.vim/.vimrc ~/.vimrc
fi

if [ -d .tmuxinator/ ]
then
    echo "* TMUXINATOR: Setting up EDITOR environment var to VIM"
    export EDITOR="vim"

    echo "* TMUXINATOR: Configuring predefined sessions"
    sudo ln -s -f .tmuxinator/sessions/* ~/.tmuxinator/
    sudo ln -s -f .tmuxinator/.tmux.conf ~/.tmux.conf
fi
