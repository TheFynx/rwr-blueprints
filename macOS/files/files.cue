{
	"directories": [
		{
			"action": "copy",
			"elevated": true,
			"group": "admin",
			"name": ".config",
			"owner": "{{ .User.username }}",
			"source": "./src/",
			"target": "{{ .User.home }}/"
		}
	],
	"files": [
		{
			"action": "copy",
			"names": [
				".aliases",
				".exports",
				".functions",
				".gitignore"
			],
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		}
	],
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
			"name": "config",
			"source": "./src/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		},
		// Same shared fish setup Arch gets (Common/fish). config.fish is rendered,
		// not copied: it branches on .System.os for the homebrew prefix and the
		// macOS network aliases.
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
		// The wine/proton/steam helpers Arch ships (dmm, _steamapps, steamid,
		// winedpi, winerun) are deliberately absent - protontricks is Linux-only.
		{
			"action": "copy",
			"names": [
				"dclean.fish",
				"digga.fish",
				"fs.fish",
				"git-check.fish",
				"isup.fish",
				"ls.fish",
				"man.fish"
			],
			"source": "../../Common/fish/functions/",
			"target": "{{ .User.home }}/.config/fish/functions/"
		}
	]
}
