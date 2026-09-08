#!/usr/bin/env bash
# Purge packages this setup does not want, quietly skipping any that are
# already absent. This replaces a packages "remove" entry: pacman -R errors
# on targets that are not installed, which made every apply report failures
# for packages that had been gone for weeks. Runs elevated, idempotent.
set -euo pipefail

for pkg in firefox alacritty nodejs shelly appimagelauncher protonup-qt pince; do
	if pacman -Qq "$pkg" >/dev/null 2>&1; then
		# Non-fatal: a distro meta-package depending on the target (likely on
		# PrismLinux) must not abort the remaining purges.
		if pacman -Rns --noconfirm "$pkg"; then
			echo "purged: $pkg"
		else
			echo "could not purge $pkg (something installed depends on it?)" >&2
		fi
	fi
done

echo "purge complete"
