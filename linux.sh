#!/bin/bash

# Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# Shell
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc

# Positron
mkdir -p ~/.config/Positron/User
ln -sf ~/dotfiles/positron/keybindings.json ~/.config/Positron/User/keybindings.json
ln -sf ~/dotfiles/positron/settings.json ~/.config/Positron/User/settings.json

echo "Dotfiles setup complete for Linux."