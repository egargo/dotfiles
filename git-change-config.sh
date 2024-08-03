#!/usr/bin/env bash

if [ "$1" == "work" ]; then
    echo "Changing git config to work config..."
    cp -v ~/.gitconfig.work ~/.gitconfig
    echo "Done."
else
    echo "Changing git config to personal config..."
    cp -v ~/.gitconfig.personal ~/.gitconfig
    echo "Done."
fi
