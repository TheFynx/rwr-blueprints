#!/bin/bash
# After suspend, force the pointer visible. Lock and sleep kill the
# screensaver before it can clear cursor:invisible itself.
set -u

lock="${XDG_RUNTIME_DIR:-/tmp}/omarchy-restore-cursor.lock"
exec 9>"$lock"
flock -n 9 || exit 0

show_pointer() {
  hyprctl eval 'hl.config({ cursor = { invisible = false } })' >/dev/null 2>&1 || true
}

show_pointer

dbus-monitor --system "type='signal',sender='org.freedesktop.login1',interface='org.freedesktop.login1.Manager',member='PrepareForSleep'" |
  while IFS= read -r line; do
    [[ $line == *"boolean false"* ]] && show_pointer
  done
