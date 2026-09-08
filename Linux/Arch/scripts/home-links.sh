#!/usr/bin/env bash
# Home symlinks into the data drive. Runs elevated (after data-drives.sh).
# Idempotent: correct links are left alone, wrong links are replaced, and an
# empty real directory is converted; a non-empty real directory is refused.
set -euo pipefail

TARGET_USER="${SUDO_USER:-levi}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
DATA_ROOT="/drives/home/${TARGET_USER}"

link_dir() {
	local name="$1"
	local src="${DATA_ROOT}/${name}"
	local dst="${TARGET_HOME}/${name}"

	# Same guard as data-drives.sh: on a machine without the data drive this
	# must skip, not leave a dangling link where a real directory belongs.
	if [ ! -d "$src" ]; then
		echo "skipping ${name}: ${src} does not exist (data drive not mounted?)" >&2
		return 0
	fi

	if [ -L "$dst" ]; then
		[ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ] || ln -sfn "$src" "$dst"
	elif [ -d "$dst" ]; then
		if [ -z "$(ls -A "$dst")" ]; then
			rmdir "$dst"
			ln -s "$src" "$dst"
		else
			echo "refusing: ${dst} is a non-empty real directory" >&2
			exit 1
		fi
	elif [ -e "$dst" ]; then
		echo "refusing: ${dst} exists and is not a directory" >&2
		exit 1
	else
		ln -s "$src" "$dst"
	fi
}

for name in Documents Downloads Pictures Videos adhoc backgrounds git; do
	link_dir "$name"
done

echo "home symlinks in place"
