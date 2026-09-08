{
	"directories": [
		{
			"action": "create",
			"group": "{{ .User.username }}",
			"name": "{{ .User.home }}/git/thefynx",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"group": "{{ .User.username }}",
			"name": "{{ .User.home }}/git/public",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"group": "{{ .User.username }}",
			"name": "{{ .User.home }}/git/fynxlabs",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"group": "{{ .User.username }}",
			"name": "{{ .User.home }}/.ssh",
			"owner": "{{ .User.username }}"
		}
	],
	"packages": [
		{
			"action": "install",
			"names": [
				"base-devel",
				"git",
				"gnupg",
				"github-cli",
				"wget",
				"curl",
				"neovim"
			],
			"package_manager": "pacman"
		}
	],
	"ssh_keys": [
		{
			"comment": "levi@fynx.me",
			"copy_to_github": true,
			"name": "git",
			"no_passphrase": true,
			"path": "{{ .User.home }}/.ssh/",
			"type": "ed25519"
		},
		{
			"comment": "levi@fynx.me",
			"copy_to_github": false,
			"name": "batocera",
			"no_passphrase": true,
			"path": "{{ .User.home }}/.ssh/",
			"type": "ed25519"
		}
	]
}
