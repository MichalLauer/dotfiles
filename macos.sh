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

# Posit Assistant Providers (disabled)
# mkdir -p ~/.posit/ai
# ln -sf ~/dotfiles/.posit/ai/providers.json ~/.posit/ai/providers.json

# Posit Assistant Setup (disabled)
# mkdir -p ~/.posit/assistant
# ln -sf ~/dotfiles/.posit/assistant/settings.json ~/.posit/assistant/settings.json

# OpenCode
mkdir -p ~/.config/opencode
ln -sf ~/dotfiles/.opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc

echo "Dotfiles setup complete for macOS."