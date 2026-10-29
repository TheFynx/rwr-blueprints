{
	"directories": [
		{
			"action": "create",
			"group": "{{ .UserDefined.USERNAME }}",
			"name": "{{ .User.home }}/git/thefynx",
			"owner": "{{ .UserDefined.USERNAME }}"
		},
		{
			"action": "create",
			"group": "{{ .UserDefined.USERNAME }}",
			"name": "{{ .User.home }}/git/public",
			"owner": "{{ .UserDefined.USERNAME }}"
		},
		{
			"action": "create",
			"group": "{{ .UserDefined.USERNAME }}",
			"name": "{{ .User.home }}/git/fynxlabs",
			"owner": "{{ .UserDefined.USERNAME }}"
		},
		{
			"action": "create",
			"group": "{{ .UserDefined.USERNAME }}",
			"name": "{{ .User.home }}/.ssh",
			"owner": "{{ .UserDefined.USERNAME }}"
		}
	],
	"packages": [
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
