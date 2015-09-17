#!/bin/bash

#
# Bootstrap for setting remote development environments.
# Version 0.0.5
echo "************************************************"
echo "*         Dotfiles bootstrap file (Development)"
echo "*         Version: 0.0.5"
echo "*         Author: Jose Vidal"
echo "*         License: MIT"
echo "************************************************"

CUR_PWD=`pwd -P` 

if [[ $1 == '' ]]
then
    echo "Please specify either 'vim' or 'tmux (or 'all' for installing the full dev environment)'"
    exit 1
fi

# Installing "common" tools
echo "* ENVIRONMENT: Installing ack-grep..."
sudo apt-get -y install ack-grep

# Set 256 colors $TERM in case it's not
if [[ $(tput colors) = 8 ]]
then
    echo "* ENVIRONMENT: Setting up 256 colors..."
    sudo echo "export TERM=screen-256color" >> ~/.bashrc
    source ~/.bashrc
fi

if [[ -d .vim  && ($1 == 'vim' || $1 == 'all') ]]
then
    echo "1) Installing VIM"
    sudo apt-get install -y vim exuberant-ctags python-autopep8 gcc
    curl -sL https://deb.nodesource.com/setup | sudo bash -
    sudo npm install -g js-beautify

    # Install vim bar symbols.
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir ~/.fonts
    mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts/

    echo "* VIM: Install Vim folder (plugins, scripts...) in ~/ ..."
    if [[ -d ~/.vim ]]
    then
        echo "* VIM: '~/.vim' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.vim
    fi
    # Copy vim folder into the user directory.
    echo "* VIM: Create symbolic link of '~/.vim' folder..."
    ln -s -f $(pwd)/.vim/ ~/
    echo "* VIM: Create symbolic link of '~/.vimrc' file..."
    # Create symbolic link of .vimrc.
    ln -s -f $(pwd)/.vim/.vimrc ~/.vimrc
    # Install all plugins.
    echo "* VIM: Installing all plugins..."
    mkdir $(pwd)/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git $(pwd)/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    echo "* VIM: Compiling plugins..."
    # Compilation required for Vimshell.
    cd $(pwd)/.vim/bundle/vimproc.vim/
    make
    cd $CUR_PWD
fi

if [[ -d .tmux && ($1 == 'tmux' || $1 == 'all') ]]
then
    echo "1) Installing TMUX and TEAMOCIL"
    # Install ruby 2.0 and rubygems.
    # Steps for installing tmux 2.0 (http://stackoverflow.com/a/25952511)
    sudo apt-get update
    sudo apt-get install -y python-software-properties software-properties-common
    sudo add-apt-repository -y ppa:pi-rho/dev
    sudo apt-get update
    sudo apt-get install -y tmux=2.0-1~ppa1~t rubygems
    cd /tmp
    wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
    tar -xvzf ruby-2.0.0-p481.tar.gz
    cd ruby-2.0.0-p481/
    ./configure --prefix=/usr/local
    make
    sudo make install
    cd $CUR_PWD 

    # Install required gems.
    sudo gem install teamocil

    if [[ -d ~/.tmux ]]
    then
        echo "* TMUX: '~/.tmux' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.tmux
    fi
    echo "* TMUX: Create symbolic link of '~/.tmux.conf' folder"
    ln -s -f $(pwd)/.tmux/ ~/

    # Install Tmux plugins manager.
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    if [[ -d .teamocil/ ]]
    then
        if [[ -d ~/.teamocil ]]
        then
            echo "* TEAMOCIL: '~/.teamocil' folder already exists. I'll replace it, sorry..."
            rm -rf ~/.teamocil
        fi
        echo "* TEAMOCIL: Create symbolic link of '~/.teamocil' folder"
        ln -s -f $(pwd)/.teamocil/ ~/
    fi
fi
