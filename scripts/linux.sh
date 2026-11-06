#!/bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Git
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig

# Shell
ln -sf "$DOTFILES/shell/.bashrc" ~/.bashrc
ln -sf "$DOTFILES/shell/.zshrc" ~/.zshrc

# Positron
mkdir -p ~/.config/Positron/User
ln -sf "$DOTFILES/positron/keybindings.json" ~/.config/Positron/User/keybindings.json
ln -sf "$DOTFILES/positron/settings.json" ~/.config/Positron/User/settings.json

# OpenCode
mkdir -p ~/.config/opencode
ln -sf "$DOTFILES/.opencode/opencode.jsonc" ~/.config/opencode/opencode.jsonc

# OpenCode skills
mkdir -p ~/.config/opencode/skills
cp -Rf "$DOTFILES/.opencode/skills/." ~/.config/opencode/skills/

echo "Dotfiles setup complete for Linux."
