// Kanata on macOS needs the Karabiner VirtualHID driver/daemon, Accessibility
// grants for kanata and kanata-tray, and the user's LaunchAgent. macOS requires
// explicit user approval for Driver Extensions and Accessibility; rwr installs
// everything around those gates and reports the exact approval still missing.
{
	"scripts": [
		{
			"action": "run"
			// Kanata 1.12 uses protocol 5 and requires VirtualHIDDevice v6.2.0.
			// Kanata 1.13+ uses the incompatible v8 driver; upgrade both together.
			"content": """
				#!/bin/bash
				set -euo pipefail

				version=6.2.0
				url="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v${version}/Karabiner-DriverKit-VirtualHIDDevice-${version}.pkg"
				sha256="9e8c46239f0748161241e42444857901224e5c82f5b58a1731df4c70bf0736a8"
				manager="/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
				plist="/Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"
				label="org.pqrs.Karabiner-VirtualHIDDevice-Daemon"

				if [ ! -x "$manager" ]; then
					tmpdir=$(mktemp -d)
					trap 'rm -rf "$tmpdir"' EXIT
					pkg="$tmpdir/virtualhid.pkg"
					curl -fL --retry 3 -o "$pkg" "$url"
					echo "$sha256  $pkg" | shasum -a 256 -c -
					sudo installer -pkg "$pkg" -target /
				fi

				# The v6 manager's normal activation flow is what presents the macOS
				# approval request. Keep it bounded because it waits for that response.
				gtimeout --kill-after=2s 15s sudo "$manager" activate || true
				if ! sudo launchctl print "system/$label" >/dev/null 2>&1; then
					sudo launchctl bootstrap system "$plist"
				fi
				sudo launchctl kickstart -k "system/$label" || true
				"""
			"exec": "bash"
			"name": "install_karabiner_virtual_hid"
		},
		{
			"action": "run"
			"content": """
				#!/bin/bash
				set -u

				uid=$(id -u)
				domain="gui/$uid"
				label="com.rszyma.kanata-tray"
				plist="$HOME/Library/LaunchAgents/$label.plist"

				if [ ! -f "$plist" ]; then
					echo "FAIL: LaunchAgent plist is missing: $plist" >&2
					exit 1
				fi
				if nc -z 127.0.0.1 5829 2>/dev/null; then
					echo "OK: kanata is already healthy (TCP 5829 up); leaving it running"
					exit 0
				fi
				if ! launchctl print "$domain/$label" >/dev/null 2>&1; then
					if ! launchctl bootstrap "$domain" "$plist"; then
						echo "FAIL: could not load LaunchAgent $plist" >&2
						exit 1
					fi
				else
					echo "kanata LaunchAgent is loaded but unhealthy; restarting it"
				fi
				if ! launchctl kickstart -k "$domain/$label"; then
					echo "FAIL: LaunchAgent is loaded but could not be started: $domain/$label" >&2
					exit 1
				fi
				sleep 6

				if nc -z 127.0.0.1 5829 2>/dev/null; then
					echo "OK: kanata running under launchd (TCP 5829 up)"
					exit 0
				fi

				echo "FAIL: kanata LaunchAgent started, but TCP 5829 is not up." >&2
				if tail -80 /tmp/kanata.log 2>/dev/null | grep -q "driver is not activated"; then
					echo "Karabiner-DriverKit-VirtualHIDDevice is installed but not activated." >&2
					if systemextensionsctl list 2>/dev/null | grep -F "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice" | grep -q "activated waiting for user"; then
						echo "macOS registered the extension as 'activated waiting for user'." >&2
						echo "The activation request is pending, but macOS has not displayed its approval control." >&2
						echo "Rerun after approving org.pqrs.Karabiner-DriverKit-VirtualHIDDevice in Driver Extensions." >&2
						echo "The blueprint cannot grant DriverKit consent on your behalf; macOS requires an interactive approval." >&2
					else
						echo "Open System Settings > General > Login Items & Extensions > Driver Extensions." >&2
						echo "Enable org.pqrs.Karabiner-DriverKit-VirtualHIDDevice, then reboot if requested." >&2
						open "x-apple.systempreferences:com.apple.LoginItems-Settings.extension" || true
					fi
				elif tail -80 /tmp/kanata.log 2>/dev/null | grep -q "Accessibility permission"; then
					echo "Kanata itself lacks macOS Accessibility permission." >&2
					echo "System Settings > Privacy & Security > Accessibility > + > Cmd+Shift+G." >&2
					echo "Add and enable BOTH /opt/homebrew/bin/kanata-tray and /opt/homebrew/bin/kanata." >&2
					echo "After a Homebrew upgrade, remove stale entries and add the current paths again." >&2
					open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility" || true
				else
					echo "See /tmp/kanata.log and /tmp/kanata-tray.err.log for the actual failure." >&2
				fi
				echo "Then rerun, or: launchctl kickstart -k $domain/$label" >&2
				exit 1
				"""
			"exec": "bash"
			"name": "verify_kanata"
		},
	]
}
