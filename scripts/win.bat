@echo off
for %%I in ("%~dp0..") do set "DOTFILES=%%~fI"

:: Git (>= v2.36)
if exist "%USERPROFILE%\.gitconfig" del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%DOTFILES%\git\.gitconfig"

:: Shell
if exist "%USERPROFILE%\.bashrc" del "%USERPROFILE%\.bashrc"
mklink "%USERPROFILE%\.bashrc" "%DOTFILES%\shell\.bashrc"

:: Positron keybinds
if exist "%APPDATA%\Positron\User\keybindings.json" del "%APPDATA%\Positron\User\keybindings.json"
mklink "%APPDATA%\Positron\User\keybindings.json" "%DOTFILES%\positron\keybindings.json"

:: Positron settings
if exist "%APPDATA%\Positron\User\settings.json" del "%APPDATA%\Positron\User\settings.json"
mklink "%APPDATA%\Positron\User\settings.json" "%DOTFILES%\positron\settings.json"

:: OpenCode
if not exist "%USERPROFILE%\.config\opencode" mkdir "%USERPROFILE%\.config\opencode"
if exist "%USERPROFILE%\.config\opencode\opencode.jsonc" del "%USERPROFILE%\.config\opencode\opencode.jsonc"
mklink "%USERPROFILE%\.config\opencode\opencode.jsonc" "%DOTFILES%\.opencode\opencode.jsonc"

:: OpenCode skills
if not exist "%USERPROFILE%\.config\opencode\skills" mkdir "%USERPROFILE%\.config\opencode\skills"
xcopy /E /I /Y "%DOTFILES%\.opencode\skills\*" "%USERPROFILE%\.config\opencode\skills\"

echo Dotfiles setup complete for Windows.
