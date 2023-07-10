# dotfiles

:house_with_garden: my `$HOME` configs

* [Alacritty](./.config/alacritty/alacritty.yml)
* [mpv](./.config/mpv/mpv.conf)
* [Neovim](./.config/nvim/)
* [Starship](./.config/starship.toml)
* [Tmux](.tmux.conf)
* [Zsh](./.zshrc)
* ~~[visual Studio Code](./config/Code/User/settings.json)~~

## Install

```bash
# Update the `dotfiles` repository
./update.sh

# Update the remote `dotfiles` repository
./push.sh


# Install alacritty, tmux, and zsh
sudo apt install alacritty tmux zsh

# Build Neovim from source
# Source: https://github.com/neovim/neovim/wiki/Building-Neovim
sudo apt-get install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Run setup
./setup.sh


# Setup Git
./git.sh <email> "<Password>"
```
