#!/bin/sh
# kanata-tray launcher shim: tray inserts `-c <config> --port <port>` right
# after kanata_executable, so sudo can't be the executable itself (its -c flag
# collides). This shim forwards everything to kanata under sudo -n, which
# works passwordless via /etc/sudoers.d/kanata.
#
# At login, kanata races the Karabiner VirtualHIDDevice daemon: if kanata
# starts first it can't connect to the virtual keyboard and exits 1 within
# seconds, leaving the tray dead for the session. Wait (bounded, 30s) for the
# daemon before starting kanata.
i=0
while ! /usr/bin/pgrep -q -f Karabiner-VirtualHIDDevice-Daemon; do
    i=$((i + 1))
    if [ "$i" -ge 30 ]; then
        break
    fi
    sleep 1
done
# Daemon just appeared at boot: give it a beat to finish initializing.
if [ "$i" -gt 0 ]; then
    sleep 1
fi
# kanata output goes to /tmp/kanata.log - the tray only logs its own side, so
# without this redirect kanata dies silently (exit 1, no reason captured).
exec /usr/bin/sudo -n /opt/homebrew/bin/kanata "$@" >> /tmp/kanata.log 2>&1
