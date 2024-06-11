#########################################################################################
# initial zsh configuration
#----------------------------------------------------------------------------------------

autoload -Uz compinit
compinit

#########################################################################################
# source external configs
#----------------------------------------------------------------------------------------

[[ ! -f "${HOME}/.aliases.sh" ]]        || source "${HOME}/.aliases.sh"
[[ ! -f "${HOME}/.functions.sh" ]]      || source "${HOME}/.functions.sh"
[[ ! -f "${HOME}/.environment.sh" ]]    || source "${HOME}/.environment.sh"
[[ ! -f "${HOME}/.cargo/env" ]]         || source "${HOME}/.cargo/env"

#########################################################################################
# Custom completion loader
#----------------------------------------------------------------------------------------

_check_eval oh-my-posh init zsh --config "${HOME}/.posh.yaml"
_check_eval docker completion zsh
_check_eval kubectl completion zsh
_check_eval fzf --zsh
