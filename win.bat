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

:: Posit Assistant Providers (disabled)
:: if not exist "%USERPROFILE%\.posit\ai" mkdir "%USERPROFILE%\.posit\ai"
:: if exist "%USERPROFILE%\.posit\ai\providers.json" del "%USERPROFILE%\.posit\ai\providers.json"
:: mklink "%USERPROFILE%\.posit\ai\providers.json" "%USERPROFILE%\dotfiles\.posit\ai\providers.json"

:: Posit Assistant Setup (disabled)
:: if not exist "%USERPROFILE%\.posit\assistant" mkdir "%USERPROFILE%\.posit\assistant"
:: if exist "%USERPROFILE%\.posit\assistant\settings.json" del "%USERPROFILE%\.posit\assistant\settings.json"
:: mklink "%USERPROFILE%\.posit\assistant\settings.json" "%USERPROFILE%\dotfiles\.posit\assistant\settings.json"

:: OpenCode
if not exist "%USERPROFILE%\.config\opencode" mkdir "%USERPROFILE%\.config\opencode"
if exist "%USERPROFILE%\.config\opencode\opencode.jsonc" del "%USERPROFILE%\.config\opencode\opencode.jsonc"
mklink "%USERPROFILE%\.config\opencode\opencode.jsonc" "%USERPROFILE%\dotfiles\.opencode\opencode.jsonc"

echo Dotfiles setup complete for Windows.