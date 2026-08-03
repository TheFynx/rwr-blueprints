{
	"directories": [
		{
			"action": "create",
			"group": "levi",
			"name": "{{ .User.home }}/git/thefynx",
			"owner": "levi"
		},
		{
			"action": "create",
			"group": "levi",
			"name": "{{ .User.home }}/git/public",
			"owner": "levi"
		},
		{
			"action": "create",
			"group": "levi",
			"name": "{{ .User.home }}/git/fynxlabs",
			"owner": "levi"
		},
		{
			"action": "create",
			"group": "levi",
			"name": "{{ .User.home }}/.ssh",
			"owner": "levi"
		}
	],
	"packages": [
		{
			"action": "install",
			"name": "base-devel"
		},
		{
			"action": "install",
			"name": "git"
		},
		{
			"action": "install",
			"name": "vim"
		},
		{
			"action": "install",
			"name": "wget"
		},
		{
			"action": "install",
			"name": "curl"
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
