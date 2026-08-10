function isup
    set -l uri $argv[1]
    set -l msg
    set -l urgency

    if curl -s --head --request GET "$uri" | grep "200 OK" >/dev/null
        set msg "$uri is up"
        set urgency low
    else
        set msg "$uri is down"
        set urgency critical
    end

    # notify-send is libnotify (Linux); macOS has no equivalent binary, so fall
    # back to Notification Center via osascript, then to stdout.
    if command -q notify-send
        notify-send --urgency=$urgency "$msg"
    else if command -q osascript
        osascript -e "display notification \"$msg\" with title \"isup\"" >/dev/null
    else
        echo "$msg"
    end
end
