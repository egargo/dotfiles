#!/bin/sh


# mkdir ~/.config
mkdir -p ~/.bee
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/nvim
mkdir -p ~/.config/zsh
mkdir -p ~/.fonts
mkdir -p ~/Projects/Personal
mkdir -p ~/Projects/GitHub
mkdir -p ~/Projects/University

dconf load / < gnome/dconf-settings.ini 2>/dev/null

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

if command -v distrobox; then
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
fi

if command -v zsh; then
    rm -rf ~/.oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    cp .zshrc ~/.zshrc 2>/dev/null
    cp .zshenv ~/.zshenv 2>/dev/null
fi
