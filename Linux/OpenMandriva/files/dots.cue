{
	"templates": [
		{
			"action": "create",
			"name": ".path",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".bashrc",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".profile",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".gitconfig",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/",
			"variables": {
				"gitEmail": "levi@fynx.me",
				"gitName": "Levi Smith",
				"signingKey": "8BF6E0074D7B228F9AF2BC76235C8EE4DF4F8767"
			}
		},
		{
			"action": "create",
			"elevated": true,
			"name": "Alacritty.desktop",
			"source": "./src/desktop/",
			"target": "{{ .User.home }}/.local/share/applications/"
		},
		{
			"action": "create",
			"name": "config",
			"source": "./src/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		}
	]
}
