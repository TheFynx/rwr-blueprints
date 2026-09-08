// Omarchy tree: the opinionated Arch + Hyprland distro gets its own tree
// because it owns most of ~/.config itself. This tree overlays only what is
// ours (keybinds, pinned nvim) and imports the shared Arch package bases.
// Matched by distro: omarchy (ID=omarchy, ID_LIKE=arch).
{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"order": ["scripts", "packages", "users", "files", "services", "git"]
	},
	// Bitwarden-backed GPG key sync: the key passphrase is read from the
	// vault item's password field (a Login item named gpg-signing) through
	// the bw CLI, falling back to the OS keyring, then a prompt. The value
	// stays out of scripts until exposeCredentials names it, and the logs
	// redact it.
	"credentials": [
		{
			"name": "gpg_passphrase",
			"description": "Passphrase of the GPG key synced via Bitwarden",
			"scope": ["scripts"],
			"sources": ["bw:gpg-signing/password", "keyring", "prompt"]
		}
	],
	"exposeCredentials": ["gpg_passphrase"]
}
