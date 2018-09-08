#!/bin/sh
# install base apps
sudo apt install terminator fonts-powerline zsh vim tmux git

# install antigen for zsh
curl -L git.io/antigen > antigen.zsh

# install node through n
curl -L https://git.io/n-install | bash

# symlink files
WD=$(realpath $(dirname $(dirname "$0")))

ln -s $WD/git/.gitconfig $HOME/.gitconfig
ln -s $WD/zsh/.zshrc $HOME/.zshrc
ln -s $WD/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $WD/vim/.vimrc $HOME/.vimrc
ln -s $WD/vim/.vim $HOME/.vim

# create folders for vim sensible settings
mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo

# install terminator profiles
terminator/install.sh
