# Init

```bash
cd ~
git clone git@github.com:MichalLauer/dotfiles.git
```

# How to run

The setup scripts live in the `scripts` folder. All of them create symlinks, so Windows needs an elevated shell (or Developer Mode) and `linux.sh` / `macos.sh` can be run as your normal user.

## Windows

Command Prompt as admin:

```cmd
scripts\win.bat
```

## Linux

```bash
cd ~/dotfiles && bash scripts/linux.sh
```

## macOS

```bash
cd ~/dotfiles && bash scripts/macos.sh
```