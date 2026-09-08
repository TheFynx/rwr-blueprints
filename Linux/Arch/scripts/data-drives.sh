#!/usr/bin/env bash
# Data drives: mount the three NVMe data disks at /drives/{home,games,storage}.
# Runs elevated. Idempotent: fstab entries are appended only when missing.
set -euo pipefail

TARGET_USER="${SUDO_USER:-levi}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
DATA_ROOT="/drives"

mount_drive() {
	local name="$1" uuid="$2"
	local dir="${DATA_ROOT}/${name}"
	local disk="/dev/disk/by-uuid/${uuid}"

	# Profile gates keep this script off other machines, but rwr applies every
	# profile when a run names none - so a wrong machine can still reach this.
	# A disk that is not here is skipped, never written into fstab.
	if [ ! -e "$disk" ]; then
		echo "skipping ${name}: no disk with UUID ${uuid} on this machine" >&2
		return 0
	fi

	mkdir -p "$dir"
	# Match on source+target via findmnt: formatting in fstab varies (tabs vs
	# spaces), so a text match would append a duplicate on every style change.
	if ! findmnt --fstab -n -S "UUID=${uuid}" -T "$dir" >/dev/null; then
		echo "/dev/disk/by-uuid/${uuid} ${dir} auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab
		echo "fstab: added ${name}"
	fi
}

# UUIDs are this workstation's hardware (nvme0 games, nvme1 storage, nvme2 home).
mount_drive home    a1b65732-5478-463a-b6f0-10a40f56663e
mount_drive games   6f8ae6e0-3f10-4a63-bce5-c16562a76176
mount_drive storage ae8d666d-cdbd-48d6-9ef9-e929c1879a26

systemctl daemon-reload
mount -a

# Content dirs the home symlinks point into; create + own them if the data
# drive is present and mounted. Without this guard a wrong machine would get
# /drives/home created on its root filesystem.
if mountpoint -q "${DATA_ROOT}/home"; then
	uid="$(id -u "$TARGET_USER")"
	gid="$(id -g "$TARGET_USER")"
	for dir in Documents Downloads Pictures Videos adhoc backgrounds git; do
		mkdir -p "${DATA_ROOT}/home/${TARGET_USER}/${dir}"
		chown "${uid}:${gid}" "${DATA_ROOT}/home/${TARGET_USER}" "${DATA_ROOT}/home/${TARGET_USER}/${dir}"
	done
else
	echo "skipping content dirs: ${DATA_ROOT}/home is not mounted" >&2
fi

echo "data drives mounted"
