#!/bin/bash -x
# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f "/etc/bashrc" ]; then
  # shellcheck disable=SC1091
  . /etc/bashrc
fi

# Load custom dotfiles
for file in ~/.{path,aliases,functions,extra,exports}; do
  # shellcheck disable=SC1090
  [[ -r "${file}" ]] && [[ -f "${file}" ]] && source "${file}"
done

# Function to update the PS1 prompt
function _update_ps1() {
  # shellcheck disable=SC2046
  PS1="$(powerline-go \
    -error $? \
    -git-mode fancy \
    -modules "venv,ssh,cwd,perms,git,jobs,exit,root,aws,docker,node,time" \
    -newline \
    -cwd-max-depth 3 \
    -theme gruvbox \
    -jobs $(jobs -p | wc -l))"
}

# McFly configuration
export MCFLY_RESULTS=100
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_FUZZY=2
export MCFLY_PROMPT="❯"
export MCFLY_HISTORY="{{ .User.home }}/.bash_history"

export PROMPT_COMMAND="history -a; history -n"

# Update the PS1 prompt if powerline-go is available and not in a Linux terminal
if [ "$TERM" != "linux" ] && [ "$(command -v powerline-go)" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
