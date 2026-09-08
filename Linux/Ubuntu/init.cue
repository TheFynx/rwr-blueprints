// Debian/Ubuntu tree: standard setup translated to apt. Shared content lives
// in Common (packages/debian, scripts/debian, files) - this tree is a thin
// selector. Matched by distro ID (debian / ubuntu).
{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"order": ["packages", "users", "scripts", "files", "services", "git"]
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
