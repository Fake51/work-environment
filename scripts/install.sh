#!/bin/bash
OLDPWD=$(pwd)
WD=$(realpath  $(dirname "$0")/..)
cd "$WD" || exit 2

create_link() {
  if [ ! -f "$2" ] && [ ! -d "$2" ]
  then
    ln -s "$1" "$2"
  fi
}

# install base apps and dependencies
echo
echo "Installing packages"
if ! sudo apt install -y \
  curl \
  dirmngr \
  fonts-powerline \
  fzf \
  git \
  keepassxc \
  neovim \
  openssl \
  ripgrep \
  terminator \
  tmux \
  unzip \
  zsh
then
  echo "Aborting - failed to install packages"
  exit 1
fi

echo

# install antigen for zsh
if [ ! -f ~/antigen.zsh ]
then
  echo "Installing Antigen for zsh"
  curl -L git.io/antigen > ~/antigen.zsh
else
  echo "Antigen in place, skipping"
fi

# symlink files and folders
create_link "$WD/git/.gitconfig" "$HOME/.gitconfig"
create_link "$WD/zsh/.zshrc" "$HOME/.zshrc"
create_link "$WD/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_link "$WD/vim/.vimrc" "$HOME/.vimrc"
create_link "$WD/vim/.vim" "$HOME/.vim"
create_link "$WD/fonts" "$HOME/.fonts"

echo
STACK=$(which stack)
if [ -z "$STACK" ]
then
    # install haskell stack
    echo "Installing haskell stack"
    curl -sSL https://get.haskellstack.org/ | sh
else
  echo "Haskell in place, skipping"
fi

# create folders for vim sensible settings
mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo

# install asdf
if [ ! -d ~/.asdf ]
then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf || exit 3
  git checkout "$(git describe --abbrev=0 --tags)"

  . $HOME/.asdf/asdf.sh
fi

echo
if ! asdf list nodejs > /dev/null
then
  echo "Installing NodeJS"
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  asdf install nodejs latest
  asdf global nodejs $(asdf latest nodejs)
else
  echo "NodeJS in place, skipping"
fi

echo
if ! asdf list elixir > /dev/null
then
  echo "Installing Erlang & Elixir"
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang latest
  asdf global erlang $(asdf latest erlang)

  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  asdf install elixir latest
  asdf global elixir $(asdf latest elixir)
else
  echo "Elixir in place, skipping"
fi

echo
if ! asdf list php > /dev/null
then
  asdf plugin-add php https://github.com/asdf-community/asdf-php.git
  VERSION=$(asdf list all php | grep -vi rc | grep -v alpha | grep -v beta | tail -n 1)
  echo "Installing PHP version $VERSION"
  asdf install php $VERSION
  asdf global php $VERSION
else
  echo "PHP in place, skipping"
fi

echo
echo "Updating fonts"
fc-cache -rv >/dev/null

# set shell
echo
echo "Setting zsh as shell"
sudo usermod -s $(which zsh) $(whoami)

# install terminator profiles
TERMINATOR_CONFIG="~/.config/terminator/"

if [ ! -d $DESTINATION ]
then
  mkdir -p $DESTINATION
  cp $WD/terminator/config $DESTINATION
fi

sed -i 's/https:\/\/github.com\//git@github.com:/' .git/config

if which gnome-terminal
then
  echo "Removing gnome-terminal"
  sudo apt remove -y gnome-terminal
fi

if [[ ! -d "$HOME/bin" ]] ; then
  mkdir "$HOME/bin"
fi

if ! which cargo ; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! which kubectl ; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

if [ ! -d "$HOME/.config" ] ; then
  mkdir -p "$HOME/.config"
fi

if [ ! -f "$HOME/.config/nvim" ] ; then
  echo << EOF > "$HOME/.config/nvim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF
fi

cd $OLDPWD
