# Init

```bash
cd ~
git clone git@github.com:MichalLauer/dotfiles.git
```

# Git (>= v2.36)

## Linux / MacOS

```bash
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
```

# Shell

## Windows [terminal]

```bash
mklink %USERPROFILE%\.bashrc %USERPROFILE%\dotfiles\shell\.bashrc
```

## Linux / MacOS

```bash
ln -sf ~/dotfiles/shell/.bashrc  ~/.bashrc
ln -sf ~/dotfiles/shell/.zshrc   ~/.zshrc
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
```

# Positron

## Windows [terminal]

```bash
mklink %APPDATA%\Positron\User\keybindings.json %USERPROFILE%\dotfiles\positron\keybindings.json 
mklink %APPDATA%\Positron\User\settings.json    %USERPROFILE%\dotfiles\positron\settings.json    
```

## MacOS

```bash
ln -s ~/dotfiles/positron/keybindings.json ~/Library/Application\ Support/Positron/User/keybindings.json
ln -s ~/dotfiles/positron/settings.json    ~/Library/Application\ Support/Positron/User/settings.json
```

## Linux

```bash
ln -sf ~/dotfiles/positron/keybindings.json ~/.config/Positron/User/keybindings.json
ln -sf ~/dotfiles/positron/settings.json    ~/.config/Positron/User/settings.json
```