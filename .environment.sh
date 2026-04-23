#########################################################################################
# Environment
# vim: ft=sh
#----------------------------------------------------------------------------------------

export DO_NOT_TRACK="true"

# prepend (higher priority)
prepend_paths=(
    "/usr/local/go/bin"
)

# append (lower priority)
append_paths=(
    "${HOME}/.local/bin"
    "${HOME}/go/bin"
    "${HOME}/.cargo/bin"
    "${HOME}/.krew/bin"
    "${HOME}/.opencode/bin"
    "${HOME}/.bun/bin"
)

# prepend loop
for p in "${prepend_paths[@]}"; do
    [ -d "${p}" ] && PATH="${p}:${PATH}"
done

# append loop
for p in "${append_paths[@]}"; do
    [ -d "${p}" ] && PATH="${PATH}:${p}"
done

BREW_BIN="/usr/local/bin/brew"
if [ -f "/opt/homebrew/bin/brew" ]; then
    BREW_BIN="/opt/homebrew/bin/brew"
fi

if type "${BREW_BIN}" &> /dev/null; then
    export BREW_PREFIX="$("${BREW_BIN}" --prefix)"
    export PATH="${BREW_PREFIX}/bin:${PATH}"
    export PATH="${BREW_PREFIX}/sbin:${PATH}"
    export PKG_CONFIG_PATH="${BREW_PREFIX}/opt/libarchive/lib/pkgconfig"

    for bindir in "${BREW_PREFIX}/opt/"*"/libexec/gnubin"; do PATH="${bindir}:${PATH}"; done
    for bindir in "${BREW_PREFIX}/opt/"*"/bin"; do PATH="${bindir}:${PATH}"; done
    for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do MANPATH="${mandir}:${MANPATH}"; done
    for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do MANPATH="${mandir}:${MANPATH}"; done
fi

export NVM_DIR="${HOME}/.nvm"

if [ -d "${NVM_DIR}" ]; then
    if [ -s "${NVM_DIR}/nvm.sh" ]; then
        source "${NVM_DIR}/nvm.sh"
    fi

    if [ -s "${NVM_DIR}/bash_completion" ]; then
        source "${NVM_DIR}/bash_completion"
    fi
fi

# export variables
export PATH MANPATH PKG_CONFIG_PATH

# if nvim exists in path (through brew or otherwise), set it as the default editor
if type "nvim" &> /dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
fi
