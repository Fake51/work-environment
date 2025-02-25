for xtra_path in '/usr/local/go/bin' "$HOME/.local/bin" "$HOME/bin/boozt" "$HOME/bin" "$HOME/.kubescape/bin"

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

for source in "$HOME/.exports" "$HOME/.aliases" "$HOME/google-cloud-sdk/completion.zsh.inc" "$HOME/google-cloud-sdk/path.zsh.inc"
do
    if [ -f "$source" ]
    then
        . $source
    fi
done

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
source ~/.local/share/kubebuilder/completion.zsh


if [[ ! -z $TMUX_PANE ]]
then

elif tmux ls >/dev/null 2>&1
then
    echo "Tmux session exists - not joining"
else
    tmux new -s "tmuxy" -n "sql" \; \
      new-window -n "boozt-cli" -d \; \
      new-window -n "projects" -d \; \
      new-window -n "terraform-gcp" -d \; \
      new-window -n "k8s" -d \; \
      new-window -n "helm" -d \; \
      new-window -n "images" -d \; \
      send-keys -t tmuxy:sql "cd ~/Sites/cloudsql/" C-m \; \
      send-keys -t tmuxy:boozt-cli "cd ~/Sites/boozt-cli/" C-m \; \
      send-keys -t tmuxy:projects "cd ~/Sites" C-m \; \
      send-keys -t tmuxy:terraform-gcp "cd ~/Sites/terraform-gcp/" C-m \; \
      send-keys -t tmuxy:k8s "cd ~/Sites/prod-euw1/" C-m \; \
      send-keys -t tmuxy:helm "cd ~/Sites/helm-charts/" C-m \; \
      send-keys -t tmuxy:images "cd ~/Sites/base-images/" C-m
fi

if [[ -f "/home/peter/.oh-my-zsh/completions/boozt.zsh" ]] ; then
    source /home/peter/.oh-my-zsh/completions/boozt.zsh
fi

if which flux > /dev/null ; then
    . <(flux completion zsh)
fi

GO_BINARIES=$(asdf where golang)/packages/bin

export PATH="$HOME/.poetry/bin:$PATH:$GO_BINARIES"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
