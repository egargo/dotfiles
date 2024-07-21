#!/usr/bin/env bash

OPTION=$1
ARG1=$2
ARG2=$3

setup_help() {
    cat <<EOF
Usage: $0 <COMMAND>

Commands:
    init            Initialization

    Languages:
        rust            Install Rust
        rustlings       Install Rustlings
        node            Install Node
        bun             Install Bun
        go              Install Go
        distrobox       Install Distrobox
        sdkman          Install SDKMAN!
        starship        Install Starship

    Debian/Ubuntu:
        ufw             Configure UFW (Debian/Ubuntu)
        apt             Install APT packages
        brave           Install Brave Browser
        neovim          Build and Install Neovim

    Fedora:
        dnf             Setup DNF configuration
        dnf             Install DNF packages

    Zsh and hostname:
        zsh             Setup ZSH
        hostname        Setup hostname
        zsh-post        ZSH post install

    config          Setup the $HOME configuration
    dconf-pop       Setup Pop!_OS (COSMIC) configuration
    flatpak         Setup Flatpak configuration
    git             Setup git configuration

    pull            Pull from remote repository
    push            Push the changes to remote repository
    update          Copy the $HOME configuration to this directory

    help            Show this help message

Usage:
    git             "Name" user@email.git
    go              1.21.1
EOF
}

setup_init() {
    # mkdir -p ~/.bee
    mkdir -p ~/.config/alacritty
    mkdir -p ~/.config/nvim
    mkdir -p ~/.config/zsh
    mkdir -p ~/.fonts
    mkdir -p ~/.local/node
    mkdir -p ~/.ssh
    # mkdir -p ~/Projects/Personal
    # mkdir -p ~/Projects/Torrents/ISO
    # mkdir -p ~/Projects/Torrents/Films
    # mkdir -p ~/Projects/Torrents/TV
    # mkdir -p ~/Projects/GitHub
    # mkdir -p ~/Projects/Work
    # mkdir -p ~/AppImages

    # git remote set-url origin git@github.com:egargo/dotfiles.git
}

setup_update() {
    cp -vR ~/.config/alacritty/* config/alacritty/ 2>/dev/null
    cp -v ~/.config/Code/User/settings.json config/Code/User/ 2>/dev/null
    cp -v ~/.config/nvim/* config/nvim/ 2>/dev/null
    cp -v ~/.config/starship.toml config/ 2>/dev/null
    cp -vR ~/.fonts/*.ttf fonts/ 2>/dev/null
    cp -vR ~/.local/share/flatpak/overrides/* local/share/flatpak/overrides/ 2>/dev/null
    cp -v ~/.tmux.conf . 2>/dev/null
    cp -v ~/.zshenv . 2>/dev/null
    cp -v ~/.zshrc . 2>/dev/null
    cp -v ~/.bashrc . 2>/dev/null
    cp -v ~/.var/app/io.gitlab.zehkira.Monophony/config/monophony/playlists.json . 2>/dev/null
}

setup_status() {
    git status .
}

setup_push() {
    git add .
    git commit -S -m "Update: $(date)"
    git push origin master
}

setup_pull() {
    git pull origin master
}

power() {
    power_design=$(upower -d | grep -w "energy-full-design:" | cut -d ":" -f2 | sed "s/ //g")
    power_full=$(upower -d | grep -w "energy-full:" | cut -d ":" -f2 | head -n 1 | sed 's/ //g')

    if [ "$power_design" == "$power_full" ]; then
        echo "Battery: OK"
    else
        echo "Battery: BAD"
    fi
}

setup_ufw() {
    if command -v ufw; then
        sudo ufw status
        sudo ufw enable
        sudo ufw default allow outgoing
        sudo ufw default deny incoming
    fi
}

setup_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

setup_rustlings() {
    curl -L https://raw.githubusercontent.com/rust-lang/rustlings/main/install.sh | bash -s "$HOME"/.local/rustlings
}

setup_node() {
    mkdir -p ~/.local/node
    curl -sL install-node.vercel.app/lts | bash -s -- -y --prefix="$HOME"/.local/node
}

setup_bun() {
    curl -fsSL https://bun.sh/install | bash
}

setup_go() {
    go_version=$1
    echo "Go Version: ${go_version}"
    rm -r ~/.local/go
    wget -O ~/.local/go${go_version}.linux-amd64.tar.gz https://go.dev/dl/go${go_version}.linux-amd64.tar.gz
    tar -xzf ~/.local/go${go_version}.linux-amd64.tar.gz -C ~/.local/
    rm ~/.local/*.gz
}

setup_sdkman() {
    curl -s https://get.sdkman.io | bash
}

setup_distrobox() {
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local/distrobox
}

setup_appimage() {
    cp -v appimage/viber.desktop ~/.local/share/applications
}

setup_starship() {
    curl -sS https://starship.rs/install.sh | sh
}

setup_dnf() {
    echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
    echo "max_parallel_downloads=12" | sudo tee -a /etc/dnf/dnf.conf
}

setup_dnf_packages() {
    sudo dnf install alacritty tmux zsh git && sudo dnf groupinstall 'C Development Tools and Libraries'
}

setup_apt() {
    sudo apt install alacritty zsh
    sudo apt-get install alacritty tmux zsh git wget ninja-build gettext cmake unzip curl
    # virt-manager
}

setup_brave() {
    sudo apt install curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
}

setup_neovim() {
    # git clone https://github.com/neovim/neovim ~/Projects/GitHub/neovim
    # cd ~/Projects/GitHub/neovim
    # git checkout stable
    # make CMAKE_BUILD_TYPE=RelWithDebInfo
    # sudo make install

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
}

setup_zsh() {
    chsh -s $(which zsh)
}

setup_hostname() {
    sudo hostnamectl set-hostname bee
}

setup_flatpak() {
    cp -v config/mpv/mpv.conf ~/.var/app/io.mpv.Mpv/config/mpv
    cp -R local/share/flatpak/overrides/ ~/.local/share/flatpak/
}

setup_config() {
    cp -R config/alacritty/* ~/.config/alacritty/ 2>/dev/null
    cp -R config/nvim/* ~/.config/nvim 2>/dev/null
    cp -R fonts/*.ttf ~/.fonts/ 2>/dev/null

    cp config/starship.toml ~/.config/starship.toml 2>/dev/null
    cp .tmux.conf ~/.tmux.conf 2>/dev/null

    # rm -rf ~/Projects/GitHub/neofetch
    # git clone https://github.com/dylanaraps/neofetch.git ~/Projects/GitHub/neofetch

    rm -rf ~/.oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    cp .zshrc ~/.zshrc 2>/dev/null
    cp .zshenv ~/.zshenv 2>/dev/null

    # if command -v code; then
    #     cp config/Code/User/settings.json ~/.config/Code/User/settings.json 2>/dev/null
    # fi
}

setup_dconf_pop() {
    dconf load / <dconf/dconf-settings.ini 2>/dev/null
}

setup_zsh_post() {
    cp -v ~/.zsh_history ~/.zsh_history.temp
    cat ~/.bash_history ~/.zsh_history.temp >~/.zsh_history
    rm -v ~/.zsh_history.temp
}

setup_git() {
    email=$1
    name=$2

    echo "Git: $name <$email>"

    mkdir -p ~/.ssh
    git config --global user.name "$name"
    git config --global user.email "$email"
    ssh-keygen -t ed25519 -C $email
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/git
    cat ~/.ssh/git.pub
    git config --global gpg.format ssh
    git config --global user.signingKey ~/.ssh/git.pub

    read -p "Add ~/.ssh/*.pub to your GitHub account's Authentication and Signing key. Done? [y/N]: " added

    added=${added^}

    if [[ "$added" == "Y" || "$added" == "YES" ]]; then
        ssh -T git@github.com
    fi
}

main() {
    case "$OPTION" in
    "apt")
        setup_apt
        ;;
    "brave")
        setup_brave
        ;;
    "bun")
        setup_bun
        ;;
    "config")
        setup_config
        ;;
    "dconf-pop")
        setup_dconf_pop
        ;;
    "distrobox")
        setup_distrobox
        ;;
    "dnf")
        setup_dnf
        ;;
    "dnf-packages")
        setup_dnf_packages
        ;;
    "flatpak")
        setup_flatpak
        ;;
    "git")
        setup_git "$ARG1" "$ARG2"
        ;;
    "go")
        setup_go "$ARG1"
        ;;
    "hostname")
        setup_hostname
        ;;
    "init")
        setup_init
        ;;
    "neovim")
        setup_neovim
        ;;
    "node")
        setup_node
        ;;
    "power")
        power
        ;;
    "pull")
        setup_pull
        ;;
    "push")
        setup_push
        ;;
    "rust")
        setup_rust
        ;;
    "sdkman")
        setup_sdkman
        ;;
    "starship")
        setup_starship
        ;;
    "status")
        setup_status
        ;;
    "ufw")
        setup_ufw
        ;;
    "update")
        setup_update
        ;;
    "zsh")
        setup_zsh
        ;;
    "zsh-post")
        setup_zsh_post
        ;;
    "help")
        setup_help
        ;;
    *)
        setup_help
        ;;
    esac
}

main
