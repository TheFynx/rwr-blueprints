{{ if eq .System.os "darwin" -}}
# ---- homebrew ----
# Outside the interactive guard on purpose: fish scripts and `fish -c` need brew's
# bin on PATH too, and nothing below (starship, mcfly, mise, eza) is on the default
# macOS PATH. Apple Silicon prefixes to /opt/homebrew, Intel to /usr/local.
for brew_prefix in /opt/homebrew /usr/local
    if test -x $brew_prefix/bin/brew
        eval ($brew_prefix/bin/brew shellenv)
        break
    end
end

{{ end -}}
# ---- cargo ----
# Cargo-installed binaries (eza, bat, topgrade, ...) land in ~/.cargo/bin on
# every OS, which is on no default PATH. Outside the interactive guard for the
# same reason as brew: scripts and `fish -c` need them too.
if test -d $HOME/.cargo/bin
    fish_add_path --global $HOME/.cargo/bin
end

if status is-interactive

    # ---- environment ----
    set -gx EDITOR nvim
    set -gx TODOTXT_DEFAULT_ACTION ls
    set -gx DOCKER_CONTENT_TRUST 0
    set -gx AWS_SDK_LOAD_CONFIG 1
    set -gx PULUMI_SKIP_UPDATE_CHECK 1

    # ---- navigation ----
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'

    # ---- git (abbr expands inline before running) ----
    abbr -a gc 'git commit -v'
    abbr -a gsc 'git commit -v -S -a -m'
    abbr -a gsa 'git commit -v -S -a --amend -m'

    # ---- grep colors ----
    alias grep 'grep --color=auto'
    alias fgrep 'fgrep --color=auto'
    alias egrep 'egrep --color=auto'

    # ---- nvim ----
    alias v nvim
    alias vi nvim
    alias vim nvim
    alias ni nvim
    alias neo nvim
    alias vcb 'nvim +BundleClean! +BundleInstall! +qall!'

    # ---- eza (ls function lives in functions/ls.fish) ----
    alias ll 'ls -lh --git'
    alias la 'ls -lbah --git'
    alias t 'ls -Ta'
    alias t1 'ls -Ta -L 1'
    alias t2 'ls -Ta -L 2'
    alias t3 'ls -Ta -L 3'
    alias t4 'ls -Ta -L 4'

    # ---- misc ----
    alias reload 'exec fish -l'
    alias week 'date +%V'
    alias hosts 'sudo nvim /etc/hosts'
    alias untar 'tar -xvf'
    alias cleanup 'topgrade -c'
    alias wget 'wget -c'
    alias pubip 'dig +short myip.opendns.com @resolver1.opendns.com'

    # ---- network ----
{{- if eq .System.os "darwin" }}
    alias flush 'sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
    alias localip 'ifconfig | grep -Eo "inet (addr:)?([0-9]+\.){3}[0-9]+" | grep -Eo "([0-9]+\.){3}[0-9]+" | grep -v 127.0.0.1'
{{- else }}
    alias flush 'sudo resolvectl flush-caches'
    alias localip 'ip -4 addr show | grep -oP "(?<=inet\s)\d+(\.\d+){3}" | grep -v 127.0.0.1'
{{- end }}

    # ---- tools ----
    # Resolved from PATH, not hardcoded: these live in /usr/bin on Arch and under
    # the brew prefix on macOS. Guarded so a machine missing one still gets a shell.
    command -q mcfly; and mcfly init fish | source
    command -q mise; and mise activate fish | source
    command -q starship; and source (starship init fish --print-full-init | psub)

    # vscode shell integration
    test "$TERM_PROGRAM" = vscode; and . (code --locate-shell-integration-path fish)

    # ---- prompt: pick ONE ----
    # starship init fish | source
    #
    # or keep powerline-go:
    # function fish_prompt
    #     powerline-go -error $status -shell bare -git-mode fancy \
    #         -modules "venv,ssh,cwd,perms,git,jobs,exit,root,aws,docker,node,time" \
    #         -newline -cwd-max-depth 3 -theme gruvbox
    # end

end

# Created by `pipx` on 2026-07-06 01:14:03
set PATH $PATH {{ .User.home }}/.local/bin
