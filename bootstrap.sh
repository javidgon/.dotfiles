#!/bin/bash

#
# Bootstrap for setting remote development environments.
# Version 0.0.3

echo "************************************************"
echo "*         Dotfiles bootstrap file (Development)"
echo "*         Version: 0.0.3"
echo "*         Author: Jose Vidal"
echo "*         License: MIT"
echo "************************************************"

# Install required applications.
echo "1) Installing main libraries: Vim, Tmux and Ruby..."
CUR_PWD=`pwd`
sudo apt-get install vim
sudo apt-get install exuberant-ctags
sudo apt-get install tmux

# Install ruby 2.0 and rubygems.
sudo apt-get install rubygems
cd /tmp
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
tar -xvzf ruby-2.0.0-p481.tar.gz
cd ruby-2.0.0-p481/
./configure --prefix=/usr/local
make
sudo make install
cd $CUR_PWD

# Install vim bar symbols.
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/

# Install auto-format for python and javascript.
sudo apt-get install python-autopep8
sudo apt-get install npm nodejs
sudo npm install -g js-beautify

# Install all plugins.
mkdir ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Install required gems.
echo "2) Fetching gems: Teamocil"
sudo gem install teamocil

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

if [ -d .teamocil/ ]
then
    echo "* TEAMOCIL: Import all the teamocil sessions available"
    sudo cp `pwd`/.teamocil/* ~/.teamocil/
fi
