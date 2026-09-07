#!/usr/bin/env bash
# Omarchy ships ufw with default-deny incoming: even SSH is blocked until
# Setup > Security > SSHD opens port 22. This is that step, headless and
# idempotent, so an Omarchy machine is reachable right after the blueprint
# applies. Gated behind the omarchy profile.
set -euo pipefail

if command -v ufw >/dev/null 2>&1; then
	ufw allow 22/tcp
fi

systemctl enable --now sshd
echo "sshd enabled, port 22 open"
