#!/bin/sh

set -ex

# Flatpaks
FLATPAKPKGS=(
    com.github.tchx84.Flatseal
    com.obsproject.Studio
    org.gimp.GIMP
    org.inkscape.Inkscape
    org.gnome.Boxes
    org.kde.kdenlive
)

# Apt
APTPKGS=(
    alacritty
    tmux
    zsh
)

for pkgs in "${FLATPAKPKGS}"
do
    flatpak install flathub "${pkgs}"
done

for pkgs in "$APTPKGS[@]}"
do
    sudo apt install "${pkgs}"
done
