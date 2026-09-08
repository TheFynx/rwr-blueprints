{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		// Exhaustive list of processors to run, in this order: rwr runs only
		// the processors named here and skips the rest silently. Scripts run
		// first so the rename-migration purges land before package installs.
		// Package files carry numeric prefixes (1-pacman.cue, 2-aur.cue) so
		// walk order keeps repo packages ahead of AUR builds.
		"order": ["scripts", "packages", "users", "files", "services", "git"]
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	],
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
