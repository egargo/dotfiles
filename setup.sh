#!/usr/bin/sh

#git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
#git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins

# mkdir ~/.config
mkdir -pv ~/.config/alacritty
mkdir -pv ~/.config/nvim

# mkdir ~/
mkdir -pv ~/.fonts

# mkdir ~/Projects
mkdir -pv ~/Projects/Personal
mkdir -pv ~/Projects/GitHub
mkdir -pv ~/Projects/University

# cp -v .config ~/.config
cp -v .fonts/*.ttf ~/.fonts/ 2>/dev/null
cp -v .config/alacritty ~/.config/alacritty/alacritty.yml 2>/dev/null
cp -v .config/Code/User/settings.json ~/.config/Code/User/settings.json 2>/dev/null
cp -v .config/nvim ~/.config/nvim/init.vim 2>/dev/null
cp -v .config/bookmarks.html ~/.config/bookmarks.html 2>/dev/null
cp -v .config/ublockorigin.txt ~/.config/ublockorigin.txt 2>/dev/null
cp -v .config/starship.toml ~/.config/starship.toml 2>/dev/null

# cp -v . ~/
cp -v .tmux.conf ~/.tmux.conf 2>/dev/null
cp -v .zshenv ~/.zshenv 2>/dev/null

