#########################################################################################
# Aliases
# vim: ft=sh
#----------------------------------------------------------------------------------------

# General

alias grep='grep --color=auto'

alias l='ls --color=auto'
alias la='ls --color=auto -al'
alias ll='ls --color=auto -l'
alias ls='ls --color=auto -a'

alias hist='cat ${HOME}/.zsh_history | grep '

alias vscsr='pkill -f "code"'
alias gpgt='echo "test" | gpg --clear-sign'
alias ssh='TERM=xterm-256color ssh'

# git
alias gcan='git commit --amend --no-edit'

# kubernetes
alias k='kubectl'
