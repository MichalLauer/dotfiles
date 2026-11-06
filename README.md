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

The local skills (`r-conventions`, `r-project`, `r-rig`) live in `.opencode/skills`.

The posit-dev skills (`r-cli`, `r-testthat`, `r-package-development`, `r-tidyverse-style`, `quarto-authoring`) are downloaded, not committed. Run this after cloning and whenever you want to update them:

```bash
cd ~/dotfiles && bash scripts/get-posit-skills.sh
```

Existing copies are overwritten.

## Todo

- Linting skill (`jarl`) — not started.
- Roxygen2 docs skill — not started. Also absent from posit-dev skills; closest third-party option is `write-roxygen-docs` from `pjt222/agent-almanac`.