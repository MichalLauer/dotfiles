#!/bin/bash

# Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# Shell
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc

# Positron
mkdir -p ~/Library/Application\ Support/Positron/User
ln -sf ~/dotfiles/positron/keybindings.json ~/Library/Application\ Support/Positron/User/keybindings.json
ln -sf ~/dotfiles/positron/settings.json ~/Library/Application\ Support/Positron/User/settings.json

echo "Dotfiles setup complete for macOS."