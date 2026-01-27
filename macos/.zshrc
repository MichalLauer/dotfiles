# Correct the path to point to the common folder
source ~/dotfiles/macos/.shell_common

# Ensure prompt substitution is active for Zsh
setopt PROMPT_SUBST

# Zsh-specific Prompt Trigger
precmd() { set_custom_prompt; }

# Autocomplete
autoload -Uz compinit && compinit