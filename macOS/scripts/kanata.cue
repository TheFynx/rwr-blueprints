// kanata autostart cannot be fully converged by rwr: macOS TCC requires the
// Accessibility grant for /opt/homebrew/bin/kanata-tray to be added by hand
// (TCC.db is SIP-protected; tccutil can only reset, never grant; only an MDM
// PPPC profile can automate it). Everything else - LaunchAgent, shim, sudoers,
// tray config - is converged by files.cue.
//
// This script is the end-to-end proof: it kickstarts the LaunchAgent and
// checks that kanata's TCP server comes up, which exercises the whole chain
// launchd -> kanata-tray -> kanata-sudo.sh -> sudo -> kanata. On a fresh
// machine it fails exactly once, opens the Accessibility pane, and prints the
// path to add; every apply after that is green.
{
	"scripts": [
		{
			"action": "run",
			"content": "#!/bin/bash\nset -u\n\nlaunchctl kickstart -k \"gui/$(id -u)/com.rszyma.kanata-tray\" || true\nsleep 6\n\nif nc -z 127.0.0.1 5829 2>/dev/null; then\n\techo \"OK: kanata running under launchd (TCP 5829 up)\"\n\texit 0\nfi\n\necho \"FAIL: kanata is not running under launchd.\" >&2\necho \"Most likely cause: Accessibility not granted to /opt/homebrew/bin/kanata-tray.\" >&2\necho \"Fix: System Settings > Privacy & Security > Accessibility > + > Cmd+Shift+G > /opt/homebrew/bin/kanata-tray, toggle ON.\" >&2\necho \"Then rerun, or: launchctl kickstart -k gui/$(id -u)/com.rszyma.kanata-tray\" >&2\necho \"kanata error log: /tmp/kanata.log | tray log: /tmp/kanata-tray.err.log\" >&2\nopen \"x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility\" || true\nexit 1\n",
			"exec": "bash",
			"name": "verify_kanata"
		}
	]
}
