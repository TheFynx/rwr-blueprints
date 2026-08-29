{
	"directories": [
		{
			"action": "create",
			"name": "{{ .User.home }}/git/thefynx",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"name": "{{ .User.home }}/git/public",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"name": "{{ .User.home }}/git/fynxlabs",
			"owner": "{{ .User.username }}"
		},
		{
			"action": "create",
			"name": "{{ .User.home }}/.ssh",
			"owner": "{{ .User.username }}"
		}
	],
	"packages": [
		{
			"action": "install",
			"names": [
				"git",
				"wget",
				"curl",
				"openssh"
			],
			"package_manager": "brew"
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
		}
	]
}
