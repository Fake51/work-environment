#!/bin/sh
# install base apps
OLDPWD=`pwd`
WD=$(realpath  $(dirname "$0")/..)
cd $WD

sudo apt install terminator fonts-powerline zsh vim tmux git curl wget

sudo usermod -s $(which zsh) $(whoami)

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
curl -L https://git.io/n-install | zsh

# create folders for vim sensible settings
mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo

# update fonts
fc-cache -rv

# install terminator profiles
$WD/terminator/install.sh

cd $OLDPWD
