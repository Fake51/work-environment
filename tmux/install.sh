#!/bin/bash

# install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

TMUXPATH=$(readlink -m $(dirname $0))
HOMEPATH=$(readlink -m ~)
ln -s $TMUXPATH/.tmux.conf $HOMEPATH/.tmux.conf
