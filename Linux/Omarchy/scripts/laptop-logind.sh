#!/usr/bin/env bash
# logind suspend policy for a closed-lid Framework (clamshell on AC), from the
# logind defaults that bite this exact shape of machine:
#
#   * HandleSuspendKey=suspend: any sleep-key press suspends instantly, and
#     the 2.4G keyboard/mouse receivers fire phantom press events, so the
#     machine slept mid-use with no idle and no lid event in the log.
#
#   * HandleLidSwitchExternalPower=suspend: with the lid closed and the
#     external display gone, the next lid-policy evaluation sleeps. The lock
#     screen blanking its display after 60 seconds is exactly that trigger —
#     lock, blank, suspend, every single time.
#
# The file writes /etc/systemd/logind.conf.d/30-debug-and-lid.conf (the same
# file the live machine already carries), stays idempotent, and NEVER
# restarts systemd-logind while a graphical session is running: restarting
# logind re-registers the seat and the running desktop dies with it. On a
# provisioned machine the file takes effect at the next boot; only a headless
# bootstrap context restarts logind here.
set -euo pipefail

DROP_IN="/etc/systemd/logind.conf.d/30-debug-and-lid.conf"

log() { echo "laptop-power: $*"; }

mkdir -p /etc/systemd/logind.conf.d

# Written in full on every run so drift between blueprint and machine cannot
# accumulate.
cat > "$DROP_IN" <<'EOF'
[Login]
# Phantom sleep-key presses from the 2.4G receivers must not suspend, and
# lid-close on AC (clamshell, external display up or dropping away) must not
# suspend. Battery lid-close still suspends, through the untouched
# HandleLidSwitch. logind debug stays on while the intermittent suspend
# caller is watched for; drop this line once it is settled.
LogLevelMax=debug
HandleSuspendKey=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitch=suspend
EOF
chmod 0644 "$DROP_IN"
log "wrote $DROP_IN"

graphical_live() {
	pgrep -x Hyprland >/dev/null 2>&1 \
		|| pgrep -x gnome-shell >/dev/null 2>&1 \
		|| pgrep -x kwin_wayland >/dev/null 2>&1
}

if graphical_live; then
	log "graphical session active: systemd-logind NOT restarted"
	log "$DROP_IN takes effect at the next boot"
else
	systemctl restart systemd-logind
	log "headless bootstrap: systemd-logind restarted, drop-in active"
fi
