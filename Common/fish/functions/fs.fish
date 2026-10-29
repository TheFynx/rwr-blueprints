function fs --description 'Apparent sizes; prefers fynx when installed'
    if command -q fynx
        fynx disk usage $argv
        return
    end

    # Fallback when fynx is not provisioned. Retire once fynx ships
    # everywhere (~/.functions behaviors live in ~/git/thefynx/cli).
    set -l arg -sh
    du -b /dev/null >/dev/null 2>&1; and set arg -sbh
    if test (count $argv) -gt 0
        du $arg -- $argv
    else
        du $arg -- * 2>/dev/null
    end
end