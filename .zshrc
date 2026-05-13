#########################################################################################
# initial zsh configuration
# vim: ft=zsh
#----------------------------------------------------------------------------------------

BREW_BIN="/usr/local/bin/brew"
if [ -f "/opt/homebrew/bin/brew" ]; then
    BREW_BIN="/opt/homebrew/bin/brew"
fi

if type "${BREW_BIN}" &> /dev/null; then
    export BREW_PREFIX="$("${BREW_BIN}" --prefix)"

    fpath=("${BREW_PREFIX}/share/zsh/site-functions" "${fpath[@]}")
fi

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

#########################################################################################
# Plugins
#----------------------------------------------------------------------------------------

export ZSH="${HOME}/.ohmyzsh"

plugins=(
    brew
    golang
    rust
    kubectl
    gh
    git
    aliases
)

if [[ "$(uname)" != "Darwin" ]]; then
    if type gpgconf &> /dev/null; then
        gpgconf --create-socketdir
    fi
fi

source "${ZSH}/oh-my-zsh.sh"
