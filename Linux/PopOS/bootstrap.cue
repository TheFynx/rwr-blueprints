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
				"git",
				"vim",
				"wget",
				"curl"
			],
			"package_manager": "apt"
		},
		{
			"action": "remove",
			"names": [
				"docker.io",
				"docker-doc",
				"docker-compose",
				"podman-docker",
				"runc",
				"containerd"
			],
			"package_manager": "apt"
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
