#!/usr/bin/env bash

option=$1

function setup_help() {
    printf "Usage: ./fedora COMMAND

    \rCommands:
        \r      init                Init
        \r      update              Update configs
        \r      push                Push configs to repo
        \r      rust                Insall rust
        \r      node                Install node
        \r      go                  Install go
        \r      sdkman              Install sdkman
        \r      starship            Install starship
        \r      dnf                 Install dnf packages
        \r      zsh                 Setup zsh
        \r      zsh-post            Zsh-post setup
        \r      hostname            Setup hostname
        \r      config              Setup config
        \r      fzf
    \r"
}

setup_init() {
    mkdir -p ~/.config/alacritty
    mkdir -p ~/.config/nvim
    mkdir -p ~/.config/zsh
    mkdir -p ~/.fonts
    mkdir -p ~/.local/node
    mkdir -p ~/.ssh
}

setup_update() {
    cp -vR ~/.config/alacritty/* config/alacritty/ 2>/dev/null
    cp -v ~/.config/Code/User/settings.json config/Code/User/ 2>/dev/null
    cp -vR ~/.config/nvim/* config/nvim/ 2>/dev/null
    cp -v ~/.config/starship.toml config/ 2>/dev/null
    cp -vR ~/.fonts/*.ttf fonts/ 2>/dev/null
    cp -vR ~/.local/share/flatpak/overrides/* local/share/flatpak/overrides/ 2>/dev/null
    cp -v ~/.tmux.conf . 2>/dev/null
    cp -v ~/.zshenv . 2>/dev/null
    cp -v ~/.zshrc . 2>/dev/null
    cp -v ~/.bashrc . 2>/dev/null
}

setup_push() {
    git add .
    git commit -S -m "Update: $(date)"
    git push origin master
}

setup_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

setup_node() {
    mkdir -p ~/.local/node
    curl -sL install-node.vercel.app/lts | bash -s -- -y --prefix="$HOME"/.local/node
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


setup_starship() {
    curl -sS https://starship.rs/install.sh | sh
}

setup_dnf() {
    sudo dnf install alacritty neovim tmux zsh
}

setup_zsh() {
    chsh -s $(which zsh)
}

setup_hostname() {
    # sudo hostnamectl set-hostname bee
    sudo hostnamectl set-hostname "$ARG1"
}

setup_config() {
    cp -R config/alacritty/* ~/.config/alacritty/ 2>/dev/null
    cp -R config/nvim/* ~/.config/nvim 2>/dev/null
    cp -R fonts/*.ttf ~/.fonts/ 2>/dev/null

    cp config/starship.toml ~/.config/starship.toml 2>/dev/null
    cp .tmux.conf ~/.tmux.conf 2>/dev/null

    rm -rf ~/.oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
    cp .zshrc ~/.zshrc 2>/dev/null
    cp .zshenv ~/.zshenv 2>/dev/null

    if command -v code; then
        cp config/Code/User/settings.json ~/.config/Code/User/settings.json 2>/dev/null
    fi
}

setup_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

setup_zsh_post() {
    cp -v ~/.zsh_history ~/.zsh_history.temp
    cat ~/.bash_history ~/.zsh_history.temp >~/.zsh_history
    rm -v ~/.zsh_history.temp
}

function main() {
    if [ "$option" == "init" ]; then
        setup_init
    elif [ "$option" == "update" ]; then
        setup_update
    elif [ "$option" == "push" ]; then
        setup_push
    elif [ "$option" == "rust" ]; then
        setup_rust
    elif [ "$option" == "node" ]; then
        setup_node
    elif [ "$option" == "go" ]; then
        setup_go
    elif [ "$option" == "sdkman" ]; then
        setup_sdkman
    elif [ "$option" == "starship" ]; then
        setup_starship
    elif [ "$option" == "dnf" ]; then
        setup_dnf
    elif [ "$option" == "zsh" ]; then
        setup_zsh
    elif [ "$option" == "zsh-post" ]; then
        setup_zsh_post
    elif [ "$option" == "hostname" ]; then
        setup_hostname
    elif [ "$option" == "config" ]; then
        setup_config
    elif [ "$option" == "fzf" ]; then
        setup_config
    else
        setup_help
    fi
}

main
