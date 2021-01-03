#!/bin/sh
OLDPWD=`pwd`
WD=$(realpath  $(dirname "$0")/..)
cd $WD

create_link() {
  if [ ! -f "$2" -a ! -d "$2" ]
  then
    ln -s "$1" "$2"
  fi
}

# install base apps and dependencies
echo "Installing packages"
if ! sudo apt install -y \
  autoconf \
  build-essential \
  curl \
  dirmngr \
  fonts-powerline \
  git \
  gnupg2 \
  keepassxc \
  libncurses-dev \
  libncurses5-dev \
  libssh-dev \
  libxml2-utils \
  m4 \
  openjdk-11-jdk \
  software-properties-common \
  terminator \
  tmux \
  unixodbc-dev \
  unzip \
  vim \
  vim-doc \
  wget \
  zsh
then
  echo "Aborting - failed to install packages"
  exit 1
fi

# install antigen for zsh
if [ ! -f ~/antigen.zsh ]
then
  echo "Installing Antigen for zsh"
  curl -L git.io/antigen > ~/antigen.zsh
fi

# symlink files and folders
create_link $WD/git/.gitconfig $HOME/.gitconfig
create_link $WD/zsh/.zshrc $HOME/.zshrc
create_link $WD/tmux/.tmux.conf $HOME/.tmux.conf
create_link $WD/vim/.vimrc $HOME/.vimrc
create_link $WD/vim/.vim $HOME/.vim
create_link $WD/fonts $HOME/.fonts

STACK=`which stack`
if [ -z "$STACK" ]
then
    # install haskell stack
    echo "Installing haskell stack"
    curl -sSL https://get.haskellstack.org/ | sh
fi

# create folders for vim sensible settings
mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo

# install asdf
if [  -d ~/.asdf ]
then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"

  . $HOME/.asdf/asdf.sh

  # nodejs
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  asdf install nodejs latest
  asdf global nodejs $(asdf latest nodejs)

  # erlang & elixir
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang latest
  asdf global erlang $(asdf latest erlang)

  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  asdf install elixir latest
  asdf global elixir $(asdf latest elixir)
fi

# update fonts
fc-cache -rv

# set shell
echo "Setting zsh as shell"
sudo usermod -s $(which zsh) $(whoami)

# install terminator profiles
#$WD/terminator/install.sh

sed -i 's/https:\/\/github.com\//git@github.com:/' .git/config

if which gnome-terminal
then
  echo "Removing gnome-terminal"
  sudo apt remove -y gnome-terminal
fi

cd $OLDPWD
