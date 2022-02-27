source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle asdf
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions
antigen bundle gradle
antigen bundle alexrochas/zsh-extract
antigen bundle alexrochas/zsh-vim-crtl-z
antigen bundle alexrochas/zsh-git-semantic-commits
antigen bundle alexrochas/zsh-path-environment-explorer
antigen bundle vi-mode

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell/oh-my-zsh themes/agnoster

# Tell Antigen that you're done.
antigen apply


export EDITOR=/usr/bin/vim
setopt VI

alias gpg=gpg2

if [ -f "$HOME/.asdf/asdf.sh" ]
then
    . $HOME/.asdf/asdf.sh
fi
if [ -d '/usr/local/go/bin' ]
then
    export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "$HOME/.local/bin" ]
then
    export PATH=$PATH:$HOME/.local/bin
fi

if [ -f "$HOME/.exports" ]
then
    . "$HOME/.exports"
fi

if [[ -d "$HOME/.emacs.d/bin" ]] ; then
    export PATH=$PATH:$HOME/.emacs/bin
fi

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

if [[ ! -z $TMUX_PANE ]]
then

elif tmux ls >/dev/null 2>&1
then
    echo "Tmux session exists - not joining"
else
    tmux
fi
