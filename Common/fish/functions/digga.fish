function digga --description 'DNS records; prefers fynx when installed'
    if command -q fynx
        fynx dns lookup $argv
        return
    end

    # Fallback when fynx is not provisioned. Retire once fynx ships
    # everywhere (~/.functions behaviors live in ~/git/thefynx/cli).
    dig +nocmd "$argv[1]" any +multiline +noall +answer
end