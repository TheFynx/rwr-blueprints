function isup
    set -l uri $argv[1]
    if curl -s --head --request GET "$uri" | grep "200 OK" >/dev/null
        notify-send --urgency=low "$uri is up"
    else
        notify-send --urgency=critical "$uri is down"
    end
end
