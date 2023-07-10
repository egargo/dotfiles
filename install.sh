#!/usr/bin/env bash

package=$1

echo "Installing $option packages..."

# Flatpaks
FLATPAKPKGS=(
    com.github.tchx84.Flatseal
    com.obsproject.Studio
    org.gimp.GIMP
    org.gnome.Boxes
    org.inkscape.Inkscape
    org.kde.kdenlive
)

# Apt
APTPKGS=(
    alacritty
    tmux
    zsh
)

# NOTE: Requires sudo
function apt() {
    for pkgs in "${APTPKGS[@]}"; do
        sudo apt install "${pkgs}"
    done
}

# NOTE: Requires sudo
function docker() {
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd docker
    sudo usermod -aG docker $USER
}

function flatpak() {
    for pkgs in "${FLATPAKPKGS[@]}"; do
        flatpak install flathub "${pkgs}"
    done
}

# NOTE: Requires sudo
function hostname() {
    sudo hostnamectl set-hostname $hostname
}

function node() {
    echo "Press 'y' to install"
    mkdir -p ~/.node
    curl -sL install-node.vercel.app/lts | bash -s -- -y --prefix=$HOME/.node
}

# NOTE: Requires sudo
function nvim() {
    sudo apt-get install ninja-build gettext cmake unzip curl
    git clone https://github.com/neovim/neovim ~/Projects/GitHub/neovim
    cd ~/Projects/GitHub/neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}

function rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

# NOTE: Requires sudo
function starship() {
    curl -sS https://starship.rs/install.sh | sh
}

# NOTE: Requires sudo
function zsh() {
    chsh -s $(which zsh)
}


function main() {
    echo "Installation finished."
}

main
