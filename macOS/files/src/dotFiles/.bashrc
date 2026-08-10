#!/bin/bash -x
# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f "/etc/bashrc" ]; then
  # shellcheck disable=SC1091
  . /etc/bashrc
fi

# McFly configuration
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_FUZZY=1
export MCFLY_PROMPT="❯❯"
export MCFLY_HISTORY="/Users/levi/.bash_history"

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
    -modules "time,cwd,node,venv,git,jobs,gcp,docker,kube" \
    -shorten-gke-names \
    -modules-right "exit" \
    -newline \
    -cwd-max-depth 3 \
    -theme gruvbox \
    -jobs $(jobs -p | wc -l))"
}

export PROMPT_COMMAND="history -a; history -n"

# Update the PS1 prompt if powerline-go is available and not in a Linux terminal
if [ "$TERM" != "linux" ] && [ "$(command -v powerline-go)" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export GOPRIVATE="github.com/phc-health/*,github.com/phc-eng/*"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
