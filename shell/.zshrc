# Correct the path to point to the common folder
source ~/dotfiles/shell/.shell_common

# Run on startup and every time the directory changes
auto_venv_activation
chpwd_functions+=(auto_venv_activation)

# Prompt settings
setopt PROMPT_SUBST
precmd() { set_custom_prompt; }
