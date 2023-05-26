#!/usr/bin/sh

# chmod +x git.sh
# ./git.sh email "Name"

email=$1
name=$2

echo "email: $email"
echo "name: $name"

ssh-keygen -t ed25519 -C "$email"
ssh-add ~/.ssh/github
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/github.pub
git config --global user.name "$name"
git config --global user.email "$email"

echo "Add ~/.ssh/*.pub to your GitHub account and run:\n"ssh -T git@github.com""

