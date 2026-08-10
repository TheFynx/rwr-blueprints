#!/bin/sh
# kanata-tray launcher shim: tray inserts `-c <config> --port <port>` right
# after kanata_executable, so sudo can't be the executable itself (its -c flag
# collides). This shim forwards everything to kanata under sudo -n, which
# works passwordless via /etc/sudoers.d/kanata.
exec /usr/bin/sudo -n /opt/homebrew/bin/kanata "$@"
