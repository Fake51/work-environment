#!/bin/bash
OLDPWD=$(pwd)
WD=$(realpath "$(dirname "$0")/..")
cd "$WD" || exit 2

create_link() {
	if [ ! -f "$2" ] && [ ! -d "$2" ]; then
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
	tmux \
	unzip \
	zsh; then
	echo "Aborting - failed to install packages"
	exit 1
fi

echo

# install antibody for zsh
if ! which antibody ; then
	echo "Installing Antigen for zsh"
	curl -sfL git.io/antibody | sh -s - -b /$HOME/.local/bin
else
	echo "Antigen in place, skipping"
fi

# symlink files and folders
create_link "$WD/git/.gitconfig" "$HOME/.gitconfig"
create_link "$WD/zsh/.zshrc" "$HOME/.zshrc"
create_link "$WD/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_link "$WD/fonts" "$HOME/.fonts"
create_link "$WD/aliases" "$HOME/.aliases"

echo
STACK=$(which stack)
if [ -z "$STACK" ]; then
	# install haskell stack
	echo "Installing haskell stack"
	curl -sSL https://get.haskellstack.org/ | sh
else
	echo "Haskell in place, skipping"
fi

# install asdf
if [ ! -d ~/.asdf ]; then
	curl -Lo asdf.tar.gz https://github.com/asdf-vm/asdf/releases/download/v0.16.4/asdf-v0.16.4-linux-amd64.tar.gz
	tar -xvzf asdf.tar.gz
	mv asdf $HOME/.local/bin/
	rm asdf.tar.gz
fi

echo
if ! asdf list elixir >/dev/null; then
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
if ! asdf list helm >/dev/null; then
	echo "Installing Helm"
	asdf plugin add helm
	asdf install helm latest
	asdf global helm latest
else
	echo "Helm in place, skipping"
fi

echo
if ! asdf list python >/dev/null; then
	echo "Installing Python"
	asdf plugin add python
	asdf install python latest
	asdf global python latest
else
	echo "Python in place, skipping"
fi

echo
if ! asdf list terraform >/dev/null; then
	echo "Installing Terraform"
	asdf plugin add terraform
	asdf install terraform latest
	asdf global terraform latest
else
	echo "Terraform in place, skipping"
fi

echo
if ! asdf list zig >/dev/null; then
	echo "Installing Zig"
	asdf plugin add zig
	asdf install zig latest
	asdf global zig latest
else
	echo "Zig in place, skipping"
fi

echo
if ! asdf list golang >/dev/null; then
	echo "Installing Go"
	asdf plugin add golang
	asdf install golang latest
	asdf global golang latest
else
	echo "Go in place, skipping"
fi

echo
echo "Updating fonts"
fc-cache -rv >/dev/null

# set shell
echo
echo "Setting zsh as shell"
sudo usermod -s $(which zsh) $(whoami)

sed -i 's/https:\/\/github.com\//git@github.com:/' .git/config

if which gnome-terminal; then
	echo "Removing gnome-terminal"
	sudo apt remove -y gnome-terminal
fi

if [[ ! -d "$HOME/bin" ]]; then
	mkdir "$HOME/bin"
fi

if ! which cargo; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! which kubectl; then
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
	mv kubectl ~/bin/
fi

if [ ! -d "$HOME/.config" ]; then
	mkdir -p "$HOME/.config"
fi

# setup lazyvim
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

cd "$OLDPWD" || exit 1
