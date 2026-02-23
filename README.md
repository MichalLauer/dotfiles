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

## Windows [terminal]

```bash
mklink %USERPROFILE%\.bashrc %USERPROFILE%\dotfiles\shell\.bashrc
```

## MacOS

```bash
ln -s ~/dotfiles/shell/.bashrc  ~/.bashrc
ln -s ~/dotfiles/shell/.zshrc   ~/.zshrc
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
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

