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
    echo "Please specify either 'vim' or 'tmux' (or 'all' for installing the full dev environment)'"
    exit 1
fi

sudo apt-get update
# Installing "common" tools
echo "0) Install COMMON tools"
echo "* GIT: Installing git..."
sudo apt-get -y install git
echo "* ACK-GREP: Installing ack-grep..."
sudo apt-get -y install ack-grep
# Check if fasd is installed
if hash fasd 2>/dev/null; then
    echo "* FASD: It's already installed."
else
    echo "* FASD: Installing fasd..."
    cd /tmp
    wget https://github.com/clvv/fasd/tarball/1.0.1 -O fasd.tar.gz
    tar zxvf fasd.tar.gz
    # This weird folder contains the fasd lib. Don't ask about the naming
    cd clvv-fasd-4822024
    sudo make install
    cd $CUR_PWD
fi
if hash fzf 2>/dev/null; then
    echo "* FZF: It's already installed."
else
    echo "* FZF: Installing fzf..."
    cd /tmp
    git clone --depth 1 https://github.com/junegunn/fzf.git fzf
    sudo fzf/install
    cd $CUR_PWD
fi
if [[ -d .vim  && ($1 == 'vim' || $1 == 'all') ]]
then
    echo "1) Installing VIM"
    sudo apt-get install -y vim exuberant-ctags python-autopep8 gcc
    if hash node 2>/dev/null; then
        echo "* NODE: It's already installed."
    else
        echo "* NODE: Installing node..."
        curl -sL https://deb.nodesource.com/setup | sudo bash -
        cd $CUR_PWD
    fi
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
    ln -s -f ${CUR_PWD}/.vim/ ~/
    echo "* VIM: Create symbolic link of '~/.vimrc' file..."
    # Create symbolic link of .vimrc.
    ln -s -f ${CUR_PWD}/.vim/.vimrc ~/.vimrc
    # Install all plugins.
    echo "* VIM: Installing all plugins..."
    mkdir ${CUR_PWD}/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ${CUR_PWD}/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    echo "* VIM: Compiling plugins..."
    # Compilation required for Vimshell.
    cd ${CUR_PWD}/.vim/bundle/vimproc.vim/
    make
    cd $CUR_PWD
fi

if [[ -d .tmux && ($1 == 'tmux' || $1 == 'all') ]]
then
    echo "1) Installing TMUX and TEAMOCIL"
    # Install ruby 2.0 and rubygems.
    # Steps for installing tmux 2.0 (http://stackoverflow.com/a/25952511)
    if hash gem 2>/dev/null; then
        echo "* RUBY: It's already installed."
    else
        echo "* RUBY: Installing ruby and gems"
        cd /tmp
        wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
        tar -xvzf ruby-2.0.0-p481.tar.gz
        cd ruby-2.0.0-p481/
        ./configure --prefix=/usr/local
        make
        sudo make install
        cd $CUR_PWD
    fi

    if hash tmux 2>/dev/null; then
        echo "* TMUX: It's already installed."
    else
        echo "* TMUX: Installing tmux"
        sudo apt-get install -y python-software-properties software-properties-common
        sudo add-apt-repository -y ppa:pi-rho/dev
        sudo apt-get update
        sudo apt-get install -y tmux=2.0-1~ppa1~t rubygems
    fi
    # Install required gems.
    sudo gem install teamocil

    if [[ -d ~/.tmux ]]
    then
        echo "* TMUX: '~/.tmux' folder already exists. I'll replace it, sorry..."
        rm -rf ~/.tmux
    fi
    echo "* TMUX: Create symbolic link of '~/.tmux.conf' folder"
    ln -s -f ${CUR_PWD}/.tmux/ ~/

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
        ln -s -f ${CUR_PWD}/.teamocil/ ~/
    fi
fi
