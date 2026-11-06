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

# OpenCode skills

The local skills (`r-conventions`, `r-project`, `r-rig`, `shiny-app`) live in `.opencode/skills`.

The downloaded skills are not committed. Run this after cloning and whenever you want to update them:

```bash
cd ~/dotfiles && bash scripts/get-skills.sh
```

Existing copies are overwritten on every run, so local edits to them are lost. Keep personal rules in the local skills instead.

### Local edits to downloaded skills

`get-skills.sh` reinstalls untouched copies. It rewrites only one thing mechanically: `dataFilterUI`/`dataFilterServer` become snake_case, to match the local `shiny-app` skill.

Every other rule this repo needs on top of a downloaded skill is in the local `shiny-app` skill, which lists them under "These override the downloaded skills". Keep personal rules there, not in the downloaded copies.

## Todo

- Linting skill (`jarl`) — not started.