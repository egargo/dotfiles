#!/bin/sh


# mkdir ~/.config
mkdir -pv ~/.config/alacritty
mkdir -pv ~/.config/nvim
mkdir -pv ~/.config/zsh
mkdir -pv ~/.fonts
mkdir -pv ~/Projects/Personal
mkdir -pv ~/Projects/GitHub
mkdir -pv ~/Projects/University


# cp -v .config ~/.config
cp fonts/*.ttf ~/.fonts/ 2>/dev/null

cp -v local/share/flatpak/overrides/* ~/.local/share/flatpak/overrides/

if command -v alacritty; then
    cp -v config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 2>/dev/null
fi

if command -v nvim; then
    cp -vR config/nvim/* ~/.config/nvim 2>/dev/null
else
    echo "Install guide: https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start"
fi

if command -v code; then
    cp -v config/Code/User/settings.json ~/.config/Code/User/settings.json 2>/dev/null
fi

if command -v starship; then
    cp -v config/starship.toml ~/.config/starship.toml 2>/dev/null
else
    echo "curl -sS https://starship.rs/install.sh | sh"
fi

# cp -v . ~/
if command -v tmux; then
    cp -v .tmux.conf ~/.tmux.conf 2>/dev/null
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
    cp -v .zshrc ~/.zshrc 2>/dev/null
    cp -v .zshenv ~/.zshenv 2>/dev/null
    echo "Finished setting up ZSH"
fi
