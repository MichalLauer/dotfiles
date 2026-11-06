#!/bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Git
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig

# Shell
ln -sf "$DOTFILES/shell/.bashrc" ~/.bashrc
ln -sf "$DOTFILES/shell/.zshrc" ~/.zshrc

# Positron
mkdir -p ~/Library/Application\ Support/Positron/User
ln -sf "$DOTFILES/positron/keybindings.json" ~/Library/Application\ Support/Positron/User/keybindings.json
ln -sf "$DOTFILES/positron/settings.json" ~/Library/Application\ Support/Positron/User/settings.json

# OpenCode
mkdir -p ~/.config/opencode
ln -sf "$DOTFILES/.opencode/opencode.jsonc" ~/.config/opencode/opencode.jsonc

# OpenCode skills
if [ -e ~/.config/opencode/skills ] || [ -L ~/.config/opencode/skills ]; then rm -rf ~/.config/opencode/skills; fi
ln -sfn "$DOTFILES/.opencode/skills" ~/.config/opencode/skills

echo "Dotfiles setup complete for macOS."
