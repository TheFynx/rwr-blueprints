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
				"signingKey": "4B01A781536D3A8A05D65E63E5A290E73B0C6040"
			}
		},
		{
			"action": "copy",
			"name": "config",
			"source": "../../Common/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		},
		{
			"action": "create",
			"name": "config.fish",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/fish/"
		},
		{
			"action": "copy",
			"name": "starship.toml",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/"
		},
		{
			"action": "copy",
			"name": "fish_variables",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/fish/"
		},
		{
			"action": "copy",
			"names": [
				"dclean.fish",
				"digga.fish",
				"dmm.fish",
				"fs.fish",
				"git-check.fish",
				"isup.fish",
				"ls.fish",
				"man.fish",
				"_steamapps.fish",
				"steamid.fish",
				"winedpi.fish",
				"winerun.fish"
			],
			"source": "../../Common/fish/functions/",
			"target": "{{ .User.home }}/.config/fish/functions/"
		}
	]
}
