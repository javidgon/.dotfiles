#!/bin/bash

#
# Bootstrap for setting remote development environments.
# Version 0.0.4
echo "************************************************"
echo "*         Dotfiles bootstrap file (Development)"
echo "*         Version: 0.0.4"
echo "*         Author: Jose Vidal"
echo "*         License: MIT"
echo "************************************************"

CUR_PWD=`pwd -P` 

if [[ $1 == '' ]]
then
    echo "Please specify either 'vim' or 'tmux'"
fi

if [[ -d .vim  &&  $1 == 'vim' ]]
then
    echo "1) Installing VIM"
    sudo apt-get install -y vim exuberant-ctags python-autopep8 npm nodejs gcc
    sudo npm install -g js-beautify

    # Install vim bar symbols.
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir ~/.fonts
    mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts/

    echo "* VIM: Install Vim folder (plugins, scripts...) in ~/ ..."
    if [ -d ~/.vim ]
    then
        echo "* VIM: '~/.vim' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.vim
    fi
    # Copy vim folder into the user directory.
    echo "* VIM: Create symbolic link of '~/.vim' folder..."
    ln -s -f `pwd`/.vim/ ~/
    echo "* VIM: Create symbolic link of '~/.vimrc' file..."
    # Create symbolic link of .vimrc.
    ln -s -f `pwd`/.vim/.vimrc ~/.vimrc
    # Install all plugins.
    mkdir `pwd`/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git `pwd`/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    # Compilation required for Vimshell.
    cd `pwd`/.vim/bundle/vimproc.vim/
    make
    cd $CUR_PWD
fi

if [[ -d .tmux/ && $1 == 'tmux' ]]
then
    echo "1) Installing TMUX and TEAMOCIL"
    # Install ruby 2.0 and rubygems.
    sudo apt-get install -y tmux rubygems
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

    if [ -d ~/.tmux ]
    then
        echo "* TMUX: '~/.tmux' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.tmux
    fi
    echo "* TMUX: Create symbolic link of '~/.tmux.conf' folder"
    ln -s -f `pwd`/.tmux/ ~/

    if [ -d .teamocil/ ]
    then
        if [ -d ~/.teamocil ]
        then
            echo "* TEAMOCIL: '~/.teamocil' folder already exists. I'll replace it, sorry..."
            rm -rf ~/.teamocil
        fi
        echo "* TEAMOCIL: Create symbolic link of '~/.teamocil' folder"
        ln -s -f `pwd`/.teamocil/ ~/
    fi
fi
