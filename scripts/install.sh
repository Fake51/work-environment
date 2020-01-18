#!/bin/sh
# install base apps
OLDPWD=`pwd`
WD=$(realpath  $(dirname "$0")/..)
cd $WD

sudo apt install -y terminator fonts-powerline zsh vim tmux git curl wget gnupg2 keepassxc elixir vim-doc

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
