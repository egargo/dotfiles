#!/usr/bin/env bash

option=$1

function setup_help() {
    printf "Usage: ./fedora COMMAND

    \rCommands:
        \r    dnf               Setup DNF
        \r    rpmfusion         Setup RPM Fusion
        \r    nvidia            Install Nvidia drivers
        \r    openh264          Install OpenH264
        \r    zsh               Change shell to ZSH
        \r    hostname          Change hostname
        \r    starship          Install starship
        \r    rust              Install Rust
        \r    node              Install Node
        \r    docker            Install Docker
        \r    flathub           Flathub
        \r    docker-install    Install Docker
        \r    docker-setup      Setup Docker
        \r    dconfup           Update dconf
        \r    dconfset          Setup dconf
        \r    help              Show this help message

    \rRequires sudo privilege
    \r"
}

function setup_dnf() {
    echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
    echo "max_parallel_downloads=12" | sudo tee -a /etc/dnf/dnf.conf
}

function setup_rpmfusion() {
    # https://rpmfusion.org/Configuration#Command_Line_Setup_using_rpm
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function setup_nvidia() {
    # https://rpmfusion.org/Howto/NVIDIA#Current_GeForce.2FQuadro.2FTesla
    sudo dnf install akmod-nvidia
    # sudo dnf install xorg-x11-drv-nvidia-cuda
}

function setup_codecs() {
    # https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
    sudo dnf install lame\* --exclude=lame-devel
    sudo dnf group upgrade --with-optional Multimedia
}

function setup_openh264() {
    # https://docs.fedoraproject.org/en-US/quick-docs/openh264/
    sudo dnf config-manager --set-enabled fedora-cisco-openh264
    sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
}

function setup_zsh() {
    # https://fedoramagazine.org/set-zsh-fedora-system/
    sudo dnf install util-linux-user
    sudo dnf install zsh
    chsh -s $(which zsh)
}

function setup_hostname() {
    # https://docs.fedoraproject.org/en-US/quick-docs/changing-hostname/
    sudo hostnamectl set-hostname bee
}

function setup_starship() {
    # https://github.com/starship/starship
    curl -sS https://starship.rs/install.sh | sh
}

function setup_rust() {
    # https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function setup_node() {
    # https://github.com/vercel/install-node
    mkdir -p ~/.local/node
    curl -sL install-node.vercel.app/lts | bash -s -- -y --prefix=$HOME/.local/node
}

function install_docker() {
    # https://developer.fedoraproject.org/tools/docker/docker-installation.html
    sudo dnf install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
}

function setup_docker() {
    # https://developer.fedoraproject.org/tools/docker/docker-installation.html
    newgrp docker
}

function setup_flathub() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

function setup_dconf() {
    cat dconf/fedora-keys-1 | dconf load /org/gnome/settings-daemon/plugins/media-keys/
    cat dconf/fedora-keys-2 | dconf load /org/gnome/desktop/wm/keybindings/
    cat dconf/fedora-keys-3 | dconf load /org/gnome/shell/keybindings/
    cat dconf/fedora-keys-4 | dconf load /org/gnome/mutter/keybindings/
    cat dconf/fedora-keys-5 | dconf load /org/gnome/mutter/wayland/keybindings/
}

function update_dconf() {
    dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > dconf/fedora-keys-1
    dconf dump /org/gnome/desktop/wm/keybindings/ > dconf/fedora-keys-2
    dconf dump /org/gnome/shell/keybindings/ > dconf/fedora-keys-3
    dconf dump /org/gnome/mutter/keybindings/ > dconf/fedora-keys-4
    dconf dump /org/gnome/mutter/wayland/keybindings/ > dconf/fedora-keys-5
}

function main() {
    if [ "$option" == "dnf" ]; then
        setup_dnf
    elif [ "$option" == "dconfup" ]; then
        update_dconf
    elif [ "$option" == "dconfset" ]; then
        setup_dconf
    elif [ "$option" == "rpmfusion" ]; then
        setup_rpmfusion
    elif [ "$option" == "nvidia" ]; then
        setup_nvidia
    elif [ "$option" == "openh264" ]; then
        setup_openh264
    elif [ "$option" == "zsh" ]; then
        setup_zsh
    elif [ "$option" == "hostname" ]; then
        setup_hostname
    elif [ "$option" == "starship" ]; then
        setup_starship
    elif [ "$option" == "rust" ]; then
        setup_rust
    elif [ "$option" == "node" ]; then
        setup_node
    elif [ "$option" == "flathub" ]; then
        setup_flathub
    elif [ "$option" == "docker-install" ]; then
        install_docker
    elif [ "$option" == "docker-setup" ]; then
        setup_docker
    elif [ "$option" == "help" ]  || [ "$option" == "" ]; then
        setup_help
    else
        setup_help
    fi
}

main
