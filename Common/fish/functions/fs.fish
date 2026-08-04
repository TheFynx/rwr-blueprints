function fs
    set -l arg -sh
    du -b /dev/null >/dev/null 2>&1; and set arg -sbh
    if test (count $argv) -gt 0
        du $arg -- $argv
    else
        du $arg -- * 2>/dev/null
    end
end
