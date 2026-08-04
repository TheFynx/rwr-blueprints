function winerun --description "Run an exe in a Steam game's Proton prefix"
    if test (count $argv) -lt 1
        echo "usage: winerun EXE [ARGS...]" >&2
        return 1
    end

    set -l appid (steamid); or return 1
    protontricks-launch --appid $appid $argv
end
