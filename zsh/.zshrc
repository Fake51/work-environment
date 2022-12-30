for xtra_path in '/usr/local/go/bin' "$HOME/.local/bin" "$HOME/bin/boozt" "$HOME/bin"

if [ -d "$xtra_path" ]
then
    export PATH=$PATH:$xtra_path
fi

export ZSH_CACHE_DIR=$(realpath $HOME/.cache/oh-my-zsh)

source <(antibody init)



# Bundles from the default repo (robbyrussell's oh-my-zsh).
antibody bundle ohmyzsh/ohmyzsh path:plugins/git
antibody bundle ohmyzsh/ohmyzsh path:plugins/pip
antibody bundle ohmyzsh/ohmyzsh path:plugins/kubectl
antibody bundle ohmyzsh/ohmyzsh path:plugins/command-not-found
antibody bundle zsh-users/zsh-completions
antibody bundle ohmyzsh/ohmyzsh path:plugins/gradle
antibody bundle alexrochas/zsh-extract
antibody bundle alexrochas/zsh-vim-crtl-z
antibody bundle alexrochas/zsh-git-semantic-commits
antibody bundle alexrochas/zsh-path-environment-explorer
antibody bundle ohmyzsh/ohmyzsh path:plugins/vi-mode

antibody bundle robbyrussell/oh-my-zsh path:lib
antibody bundle robbyrussell/oh-my-zsh path:themes/agnoster.zsh-theme
##
## Syntax highlighting bundle.
antibody bundle zsh-users/zsh-syntax-highlighting


export EDITOR=/usr/bin/vim
setopt VI

alias gpg=gpg2
alias gs="git status"
alias ap='arc patch --nocommit --nobranch'
alias k=kubectl

for source in "$HOME/.exports" "$HOME/google-cloud-sdk/completion.zsh.inc" "$HOME/google-cloud-sdk/path.zsh.inc" "$HOME/.asdf/asdf.sh" "/usr/local/go/bin"
do
    if [ -f "$source" ]
    then
        . $source
    fi
done

alias m=microk8s
alias mk="m kubectl"
alias mkg="mk get"
alias mkgn="mkg nodes"
alias mkgp="mkg pods"
alias mke="mk edit"


if [[ -d "$HOME/.emacs.d/bin" ]] ; then
    export PATH=$PATH:$HOME/.emacs.d/bin
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

if [[ -f "/home/peter/.oh-my-zsh/completions/boozt.zsh" ]] ; then
    source /home/peter/.oh-my-zsh/completions/boozt.zsh
fi

export PATH="$HOME/.poetry/bin:$PATH"
