function steamid --description "Pick a Steam app ID (fzf, or numbered menu)"
    set -l apps (_steamapps $argv)

    if test (count $apps) -eq 0
        echo "steamid: no games found. try: steamid --refresh" >&2
        return 1
    end

    if type -q fzf
        set -l pick (printf '%s\n' $apps \
            | fzf --delimiter=\t --with-nth=2.. --prompt='game > ' --height=40%)
        test -z "$pick"; and return 1
        string split -f1 \t -- $pick
    else
        for i in (seq (count $apps))
            printf '%3d) %s\n' $i (string split -f2 \t -- $apps[$i]) >&2
        end
        read -l -P 'select # > ' n
        if not string match -qr '^\d+$' -- "$n"; or test $n -lt 1 -o $n -gt (count $apps)
            echo "steamid: invalid selection" >&2
            return 1
        end
        string split -f1 \t -- $apps[$n]
    end
end
