function _steamapps --description "Cached Steam apps as 'appid<TAB>name'"
    set -l cache $HOME/.cache/protontricks-games.tsv

    if contains -- --refresh $argv; or not test -s $cache
        mkdir -p (dirname $cache)
        protontricks -l 2>/dev/null \
            | string match -er '\(\d+\)\s*$' \
            | string replace -r '^\s*(.*?)\s*\((\d+)\)\s*$' '$2\t$1' \
            > $cache
    end

    cat $cache
end
