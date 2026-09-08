#!/usr/bin/env bash
# Flathub + the flatpak-only apps from the standard setup (Bambu Studio,
# Protontricks). Elevated; idempotent.
set -euo pipefail

command -v flatpak >/dev/null 2>&1 || { echo "flatpak missing; run the base apt apply first" >&2; exit 1; }

flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak_install() {
	local app="$1"
	flatpak list --system --app 2>/dev/null | grep -q "$app" && { echo "flatpak: $app already present"; return 0; }
	flatpak install -y --system flathub "$app" && echo "flatpak: installed $app"
}

flatpak_install io.github.BambuStudio
flatpak_install com.github.Matoking.protontricks

echo "flatpak apps settled"
