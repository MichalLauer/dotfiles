# Correct the path to point to the common folder
source ~/dotfiles/macos/.shell_common

# Bash-specific Prompt Trigger
PROMPT_COMMAND="auto_venv_activation; set_custom_prompt"

# Autocomplete
for f in "/opt/homebrew/etc/profile.d/bash_completion.sh" "/usr/local/etc/profile.d/bash_completion.sh"; do
    [[ -r "$f" ]] && source "$f" && break
done