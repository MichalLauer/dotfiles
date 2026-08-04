@echo off
:: Git (>= v2.36)
if exist "%USERPROFILE%\.gitconfig" del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfiles\git\.gitconfig"

:: Shell
if exist "%USERPROFILE%\.bashrc" del "%USERPROFILE%\.bashrc"
mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfiles\shell\.bashrc"

:: Positron keybinds
if exist "%APPDATA%\Positron\User\keybindings.json" del "%APPDATA%\Positron\User\keybindings.json"
mklink "%APPDATA%\Positron\User\keybindings.json" "%USERPROFILE%\dotfiles\positron\keybindings.json"

:: Positron settings
if exist "%APPDATA%\Positron\User\settings.json" del "%APPDATA%\Positron\User\settings.json"
mklink "%APPDATA%\Positron\User\settings.json" "%USERPROFILE%\dotfiles\positron\settings.json"

echo Dotfiles setup complete for Windows.