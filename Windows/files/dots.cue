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
			"action": "copy",
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
				"gitName": "Levi Smith"
			}
		},
		{
			"action": "copy",
			"name": "config",
			"source": "./src/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		},
		{
			"action": "copy",
			"elevated": true,
			"name": "Alacritty.desktop",
			"source": "./src/desktop/",
			"target": "{{ .User.home }}/.local/share/applications/"
		}
	]
}
