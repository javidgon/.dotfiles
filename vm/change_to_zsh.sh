# Change terminal to ZSH.
echo "1) Installing ZSH and Oh-my-zsh"
sudo apt-get install -y zsh
echo "* ZSH: Configure it as the default shell"
sudo usermod -s /usr/bin/zsh ${USER}
echo "* ZSH: Install Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "* ZSH: Create symbolic link of '~/.zshrc'"
ln -s -f ${CUR_PWD}/.zsh/.zshrc ~/
