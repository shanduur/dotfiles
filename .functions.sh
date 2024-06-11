#########################################################################################
# UTILITES
#----------------------------------------------------------------------------------------

# determining if tput is installed, and then setting colors
which tput 2>&1 > /dev/null
if [[ $? -eq "0" ]]; then
    _COLOR_NC="$(tput sgr0)"
    _COLOR_RED="$(tput setaf 1)"
    _COLOR_GREEN="$(tput setaf 2)"
    _COLOR_YELLOW="$(tput setaf 3)"
    _COLOR_BLUE="$(tput setaf 4)"
fi

function echo_info() {
# @brief: print message to stderr with INFO prefix
    echo -e "[${_COLOR_GREEN}INFO${_COLOR_NC}]" "$@" >&2
}

function echo_erro() {
# @brief: print message to stderr with ERRO prefix
    echo -e "[${_COLOR_RED}ERRO${_COLOR_NC}]" "$@" >&2
    exit 1
}

function echo_warn() {
# @brief: print message to stderr with WARN prefix
    echo -e "[${_COLOR_YELLOW}WARN${_COLOR_NC}]" "$@" >&2
}

function echo_extra() {
# @brief: print message to stderr with EXTR prefix
    echo -e "[${_COLOR_BLUE}EXTR${_COLOR_NC}]" "$@" >&2
}

#########################################################################################
# zsh functions
#----------------------------------------------------------------------------------------

function resrc() {
  source ~/.zshrc
  echo "sourcing '~/.zshrc' finished"
}

function batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

function kcf() {(
  KUBECONFIG=""
  for f in "${HOME}"/.kube/config.d/*; do
    if [[ -z "${KUBECONFIG}" ]]; then
      KUBECONFIG="${f}"
    else
      KUBECONFIG="${KUBECONFIG}":"${f}"
    fi
  done

  echo_extra "KUBECONFIG=${KUBECONFIG}"
  KUBECONFIG="${KUBECONFIG}" kubectl config view --flatten > "${HOME}"/.kube/config
  chmod 600 "${HOME}"/.kube/config
)}

function upd8() {
  # loop through arguments
  for arg in "$@"
  do
    # case through known arguments, eg. 'talosctl'
    case $arg in
      brew)
        brew update && brew upgrade && brew upgrade --cask --greedy
        ;;
      rust)
        if [ ! -x "$(command -v rustup)" ]; then
          echo "rustup not installed, installing..."
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        fi
        # update rust
        rustup update
        ;;
      krew)
        # update krew
        if ! kubectl krew version > /dev/null; then
          (
            set -x; cd "$(mktemp -d)" &&
            OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
            ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
            KREW="krew-${OS}_${ARCH}" &&
            curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
            tar zxvf "${KREW}.tar.gz" &&
            ./"${KREW}" install krew
          )
        fi
        kubectl krew upgrade
        ;;
      *)
        echo "unknown argument: $arg"
        ;;
    esac
  done
}

function _check_eval() {
    if command -v "${1}" 2>&1 >/dev/null; then
        eval "$(${@})"
    fi
}
