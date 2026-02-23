# Init

```bash
cd ~
git clone git@github.com:MichalLauer/dotfiles.git
```

# Git (>= v2.36)

## MacOS

```bash
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

```

# Shell

## Windows

```cmd
mklink %USERPROFILE%\.bashrc %USERPROFILE%\dotfiles\shell\.bashrc
```

## MacOS

```bash
ln -s ~/dotfiles/shell/.bashrc ~/.bashrc
ln -s ~/dotfiles/shell/.zshrc ~/.zshrc
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
```

# Positron

## MacOS

```bash
ln -s ~/dotfiles/positron/keybindings.json ~/Library/Application\ Support/Positron/User/keybindings.json
ln -s ~/dotfiles/positron/settings.json ~/Library/Application\ Support/Positron/User/settings.json
```