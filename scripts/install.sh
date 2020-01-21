#!/bin/sh
# install base apps
OLDPWD=`pwd`
WD=$(realpath  $(dirname "$0")/..)
cd $WD

sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

PHP_VERSION=`apt-cache search php | grep '^php[0-9.]\+ ' | sort -r | head -n 1 | cut -d ' ' -f 1`

sudo apt install -y terminator fonts-powerline zsh vim tmux git curl wget gnupg2 keepassxc elixir vim-doc
sudo apt install -y $PHP_VERSION php-xdebug $PHP_VERSION-bz2 $PHP_VERSION-cli $PHP_VERSION-fpm $PHP_VERSION-curl $PHP_VERSION-intl $PHP_VERSION-json $PHP_VERSION-mysql $PHP_VERSION-opcache $PHP_VERSION-sqlite3 $PHP_VERSION-tidy $PHP_VERSION-zip $PHP_VERSION-readline php-yaml $PHP_VERSION-xml

# install antigen for zsh
curl -L git.io/antigen > ~/antigen.zsh

# symlink files and folders
ln -s $WD/git/.gitconfig $HOME/.gitconfig
ln -s $WD/zsh/.zshrc $HOME/.zshrc
ln -s $WD/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $WD/vim/.vimrc $HOME/.vimrc
ln -s $WD/vim/.vim $HOME/.vim
ln -s $WD/fonts $HOME/.fonts

# install node through n
curl -L https://git.io/n-install | bash

# create folders for vim sensible settings
mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo

# update fonts
fc-cache -rv

sudo usermod -s $(which zsh) $(whoami)

# install terminator profiles
$WD/terminator/install.sh

sed -i 's/https:\/\/github.com\//git@github.com:/' .git/config

if which gnome-terminal
then
    sudo apt remove -y gnome-terminal
fi

cd $OLDPWD
