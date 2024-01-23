#!/usr/bin/env bash

option=$1
email=$2
name=$3

function setup_help() {
    printf "Usage: dotfiles-setup <COMMAND>

    \rCommands:
        \r\tinit            Initialization
        \r\tupdate          Copy the $HOME configuration to this directory
        \r\tpush            Push the changes to remote repository
        \r\tconfig          Setup the $HOME configuration
        \r\tpower           Check battery

        \r\tufw             Configure UFW

        \r\tapt             Install APT packages
        \r\trust            Install Rust
        \r\tjust            Install just
        \r\trustlings       Install Rustlings
        \r\tnode            Install Node
        \r\tdistrobox       Install Distrobox
        \r\tdistrobox-init  Initialize Distrobox for development
        \r\tstarship        Install Starship
        \r\tneovim          Build and Install Neovim
        \r\tzsh             Setup ZSH
        \r\tzsh-post        ZSH post install
        \r\thostname        Setup hostname
        \r\tgit             Setup git configuration

        \r\thelp            Show this help message

    \rUsage:
        \r\tgit             user@email.git \"Name\"
    \r"
}

function setup_init() {
    # mkdir -p ~/.local/custom
    # cp -v dotfiles-setup.sh ~/.local/custom/dotfiles-setup
    # ln -s ~/Projects/Personal/dotfiles/dotfiles-setup.sh ~/.local/custom/dotfiles-setup

    mkdir -p ~/.bee
    mkdir -p ~/.config/alacritty
    mkdir -p ~/.config/nvim
    mkdir -p ~/.config/zsh
    mkdir -p ~/.fonts
    mkdir -p ~/Projects/Personal
    mkdir -p ~/Projects/ISO
    mkdir -p ~/Projects/Torrents
    mkdir -p ~/Projects/GitHub
    mkdir -p ~/Projects/University

    git remote set-url origin git@github.com:egargo/dotfiles.git
}

function setup_update() {
    cp -v  ~/.config/alacritty/alacritty.yml config/alacritty/ 2>/dev/null
    cp -v  ~/.config/Code/User/settings.json config/Code/User/ 2>/dev/null
    cp -v  ~/.config/nvim/* config/nvim/ 2>/dev/null
    cp -v  ~/.config/starship.toml config/ 2>/dev/null
    cp -vR ~/.fonts/*.ttf fonts/ 2>/dev/null
    cp -vR ~/.local/share/flatpak/overrides/* local/share/flatpak/overrides/ 2>/dev/null
    cp -v  ~/.tmux.conf . 2>/dev/null
    cp -v  ~/.zshenv . 2>/dev/null
    cp -v  ~/.zshrc . 2>/dev/null
    cp -v  ~/.basrc . 2>/dev/null
    # dconf dump / > dconf/dconf-settings.ini
}

function setup_push() {
    git add ~/Projects/Personal/dotfiles/
    git commit -S -m "Update: $(date)"
    git push origin master
}

function power() {
    power_design=$((upower -d | grep -w "energy-full-design:" | cut -d ':' -f2) | sed 's/ //g')
    power_full=$((upower -d | grep -w "energy-full:" | cut -d ':' -f2 | head -n 1) | sed 's/ //g')

    if [ "$power_design" == "$power_full" ]; then
        echo "Battery: OK"
    else
        echo "Battery: BAD"
    fi
}

function setup_ufw() {
    if command -v ufw; then
        sudo ufw status
        sudo ufw enable
        sudo ufw default allow outgoing
        sudo ufw default deny incoming
        sudo ufw allow 51413
    fi
}

function setup_apt() {
    sudo apt install alacritty tmux zsh
}

function setup_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function setup_just() {
    mkdir -p ~/.local/just
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $HOME/.local/just
}

function setup_rustlings() {
    curl -L https://raw.githubusercontent.com/rust-lang/rustlings/main/install.sh | bash -s $HOME/.local/rustlings
}

function setup_node() {
    mkdir -p ~/.local/node
    curl -sL install-node.vercel.app/lts | bash -s -- -y --prefix=$HOME/.local/node
}

function setup_starship() {
    curl -sS https://starship.rs/install.sh | sh
}

function setup_distrobox() {
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local/distrobox
}

function setup_distrobox_init() {
    sudo apt install git build-essential libmysqlclient-dev
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    curl -sS https://starship.rs/install.sh | sh
}

function setup_zsh() {
    chsh -s $(which zsh)
}

function setup_zsh_post() {
    cp -v ~/.zsh_history ~/.zsh_history.temp
    cat ~/.bash_history ~/.zsh_history.temp > ~/.zsh_history
    rm -v ~/.zsh_history.temp
}

function setup_hostname() {
    sudo hostnamectl set-hostname bee
}

function setup_config() {
    # cp .config ~/.config
    cp fonts/*.ttf ~/.fonts/ 2>/dev/null

    cp -R local/share/flatpak/overrides/ ~/.local/share/flatpak/

    if command -v alacritty; then
        cp config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 2>/dev/null
    fi

    if command -v nvim; then
        cp -R config/nvim/* ~/.config/nvim 2>/dev/null
    else
        echo "Install guide: https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start"
    fi

    if command -v code; then
        cp config/Code/User/settings.json ~/.config/Code/User/settings.json 2>/dev/null
    fi

    if command -v starship; then
        cp config/starship.toml ~/.config/starship.toml 2>/dev/null
    else
        echo "curl -sS https://starship.rs/install.sh | sh"
    fi

    # cp . ~/
    if command -v tmux; then
        cp .tmux.conf ~/.tmux.conf 2>/dev/null
    fi

    rm -rf ~/Projects/GitHub/neofetch
    git clone https://github.com/dylanaraps/neofetch.git ~/Projects/GitHub/neofetch

    if command -v zsh; then
        rm -rf ~/.oh-my-zsh
        curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        git clone https://github.com/sobolevn/wakatime-zsh-plugin.git ~/.oh-my-zsh/custom/plugins/wakatime
        cp .zshrc ~/.zshrc 2>/dev/null
        cp .zshenv ~/.zshenv 2>/dev/null
    fi

    dconf load / < dconf/dconf-settings.ini 2>/dev/null
}

function setup_neovim() {
    sudo apt-get install ninja-build gettext cmake unzip curl
    git clone https://github.com/neovim/neovim ~/Projects/GitHub/neovim
    cd ~/Projects/GitHub/neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}

function setup_git() {
    echo "email: $email"
    echo "name: $name"

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

function main() {
    if [ "$option" == "init" ]; then
        setup_init
    elif [ "$option" == "update" ]; then
        setup_update
   elif [ "$option" == "push" ]; then
       setup_push
    elif [ "$option" == "config" ]; then
        setup_config
    elif [ "$option" == "power" ]; then
        power
    elif [ "$option" == "ufw" ]; then
        setup_ufw
    elif [ "$option" == "apt" ]; then
        setup_apt
    elif [ "$option" == "neovim" ]; then
        setup_neovim
    elif [ "$option" == "rust" ]; then
        setup_rust
    elif [ "$option" == "rustlings" ]; then
        setup_rustlings
    elif [ "$option" == "just" ]; then
        setup_just
    elif [ "$option" == "node" ]; then
        setup_node
    elif [ "$option" == "distrobox" ]; then
        setup_distrobox
    elif [ "$option" == "distrobox-init" ]; then
        setup_distrobox_init
    elif [ "$option" == "starship" ]; then
        setup_starship
    elif [ "$option" == "zsh" ]; then
        setup_zsh
    elif [ "$option" == "zsh-post" ]; then
        setup_zsh_post
    elif [ "$option" == "hostname" ]; then
        setup_hostname
    elif [ "$option" == "git" ]; then
        setup_git
    elif [ $"option" == "help" ]; then
        setup_help
    else
        setup_help
    fi
}

main
