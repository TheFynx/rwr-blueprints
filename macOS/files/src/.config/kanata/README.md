# kanata on macOS - how the pieces fit

Debugged 2026-08-20. Keep this current if any path changes.

## Chain at login

launchd (`~/Library/LaunchAgents/com.rszyma.kanata-tray.plist`, RunAtLoad)
-> `kanata-tray` (config: `~/Library/Application Support/kanata-tray/kanata-tray.toml`)
-> `~/.config/kanata/kanata-sudo.sh` (waits for Karabiner VHID daemon, logs to `/tmp/kanata.log`)
-> `sudo -n kanata` (passwordless via `/etc/sudoers.d/kanata`)
-> kanata TCP server on 127.0.0.1:5829 (tray connects to it)

## Manual step rwr cannot do (TCC)

System Settings > Privacy & Security > Accessibility must include
`/opt/homebrew/bin/kanata-tray` (the stable opt symlink - this is the pinned
entry, and it survives brew upgrades), toggled ON.

Under launchd, macOS attributes the Accessibility check to the responsible
process, which is kanata-tray - NOT the kanata binary sudo spawns. Granting
only kanata does not help. Terminal runs mask the problem entirely because the
process inherits the terminal's grant, so "works in my shell, dies at login"
is the signature of a missing/stale grant.

`scripts/kanata.cue` (verify_kanata) proves the whole chain after apply and
opens the Accessibility pane with instructions when the grant is missing.

## Troubleshooting

- kanata's own errors: `/tmp/kanata.log` (the tray only logs its side)
- tray/launchd logs: `/tmp/kanata-tray.err.log`, `/tmp/kanata-tray.out.log`
- relaunch: `launchctl kickstart -k gui/$(id -u)/com.rszyma.kanata-tray`
  (`launchctl load` refuses with "already loaded" - kickstart is the way)
- `autorestart_on_crash = true` in kanata-tray.toml retries crashes, but the
  tray disables it above 2 restarts/min, so it alone does not survive fast
  crash loops (missing TCC grant, boot race) - hence the shim's daemon wait
  and the TCC note above.
