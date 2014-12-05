#!/bin/bash

# symlink .vim and .vimrc
TMUXPATH=$(readlink -m $(dirname $0))
HOMEPATH=$(readlink -m ~)

ln -s $TMUXPATH/.vim $HOMEPATH/.vim
ln -s $TMUXPATH/.vimrc $HOMEPATH/.vimrc
