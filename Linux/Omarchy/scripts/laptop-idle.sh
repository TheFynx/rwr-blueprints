#!/usr/bin/env bash
# Omarchy idle timings for the laptop, as the invoking user: 10 minutes to the
# screensaver, 15 minutes to the lock (five minutes after the screensaver is
# up, and only while the screensaver is still showing), and 60 seconds to the
# lock screen's own blank. Mirrors the values declared in
# configuration/omarchy.cue — a provisioning run converges first-time machines
# through the declaration; this script converges an already-used machine under
# a --laptop run, because panel-set values on a live desktop drift away from
# provisioning-time state. Idempotent: these are assignments, not toggles.
set -euo pipefail

SHELL_JSON="${HOME}/.config/omarchy/shell.json"

log() { echo "laptop-power: $*"; }

if ! command -v jq >/dev/null; then
	log "jq unavailable; cannot edit $SHELL_JSON"
	exit 1
fi

if [[ ! -f $SHELL_JSON ]]; then
	log "no shell.json at $SHELL_JSON; nothing to do"
	exit 0
fi

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

jq '
	.idle.screensaver = 600
	| .idle.lock = 900
	| .plugins = ((.plugins // [])
		| map(if .id == "io.github.sirjul1337.lock-explorer" then .blankMs = 60000 else . end))
' "$SHELL_JSON" > "$tmp"
mv "$tmp" "$SHELL_JSON"

log "shell.json: idle.screensaver=600 idle.lock=900 blankMs=60000"
log "the shell hot-reloads shell.json on save; no restart needed"
