#!/usr/bin/env bash
# AstroNvim, pinned. Checks out ~/.config/nvim at the template commit pinned
# below; plugin versions come from the committed lazy-lock.json (deployed via
# the files processor). Deliberate updates: bump both, then regen the lock.
# Runs unprivileged and tolerates an existing non-empty config directory.
set -euo pipefail

NVIM_DIR="${HOME}/.config/nvim"
REPO="https://github.com/AstroNvim/template"
PINNED="49a7161b776f8bc6c23508819ea1ad4e7b359bee"

if [ ! -d "${NVIM_DIR}/.git" ]; then
	git init -q "$NVIM_DIR"
	git -C "$NVIM_DIR" remote add origin "$REPO"
fi

git -C "$NVIM_DIR" fetch --depth 1 --quiet origin "$PINNED"

if [ "$(git -C "$NVIM_DIR" rev-parse HEAD 2>/dev/null || true)" != "$PINNED" ]; then
	git -C "$NVIM_DIR" checkout --quiet --detach FETCH_HEAD
	echo "nvim: template pinned at ${PINNED}"
else
	echo "nvim: template already at ${PINNED}"
fi
