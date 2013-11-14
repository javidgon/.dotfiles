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
if [ -d .vim ]
then
    echo "* VIM: Install Vim folder (plugins, scripts...) in ~/ ..."
    if [ -d ~/.vim ]
    then
        echo "* VIM: '~/.vim' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.vim
    fi
    # Copy vim folder into the user directory.
    echo "* VIM: Create symbolic link of '~/.vim' folder..."
    sudo ln -s -f `pwd`/.vim/ ~/
    echo "* VIM: Create symbolic link of '~/.vimrc' file..."
    # Create symbolic link of .vimrc.
    sudo ln -s -f `pwd`/.vim/.vimrc ~/.vimrc
fi

if [ -d .tmux/ ]
then
    echo "* TMUX: Create symbolic link of '~/.tmux.conf' file..."
    sudo ln -s -f `pwd`/.tmux/.tmux.conf ~/.tmux.conf
fi

if [ -d .tmuxinator/ ]
then
    echo "* TMUXINATOR: Setting up EDITOR environment var to VIM..."
    export EDITOR="vim"

    echo "* TMUXINATOR: Configuring predefined sessions..."
    if [ -d ~/.tmuxinator/ ]
    then
        echo "* TMUXINATOR: '~/.tmuxinator' folder already exist, I don't need to create it then..."
    else
        echo "* TMUXINATOR: '~/.tmuxinator' folder does not exist, I will have to create it then..."
        mkdir ~/.tmuxinator
    fi
    # Sessions to install.
    echo "* TMUXINATOR: Create symbolic link of '~/.tmuxinator/dev.yml' file..."
    sudo ln -s -f `pwd`/.tmuxinator/dev.yml ~/.tmuxinator/
fi
