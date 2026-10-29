function man --description 'Colored manual pages; prefers fynx when installed'
    if command -q fynx
        fynx man $argv
        return
    end

    # Fallback when fynx is not provisioned. Retire once fynx ships
    # everywhere (~/.functions behaviors live in ~/git/thefynx/cli).
    set -lx LESS_TERMCAP_mb (printf "\e[1;31m")
    set -lx LESS_TERMCAP_md (printf "\e[1;31m")
    set -lx LESS_TERMCAP_me (printf "\e[0m")
    set -lx LESS_TERMCAP_se (printf "\e[0m")
    set -lx LESS_TERMCAP_so (printf "\e[1;44;33m")
    set -lx LESS_TERMCAP_ue (printf "\e[0m")
    set -lx LESS_TERMCAP_us (printf "\e[1;32m")
    command man $argv
end