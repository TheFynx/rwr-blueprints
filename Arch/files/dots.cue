{
	"templates": [
		{
			"action": "create",
			"name": ".path",
			"source": "../../Common/linux-dotfiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".bashrc",
			"source": "../../Common/linux-dotfiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "copy",
			"name": ".profile",
			"source": "../../Common/linux-dotfiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".gitconfig",
			"source": "../../Common/linux-dotfiles/",
			"target": "{{ .User.home }}/",
			"variables": {
				"gitEmail": "levi@fynx.me",
				"gitName": "Levi Smith",
				"signingKey": "8BF6E0074D7B228F9AF2BC76235C8EE4DF4F8767"
			}
		},
		{
			"action": "copy",
			"name": "config",
			"source": "../../Common/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		}
	]
}
