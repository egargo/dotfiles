#/bin/sh

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
dconf dump / > gnome/dconf-settings.ini
