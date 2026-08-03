{
	"directories": [
		{
			"action": "copy",
			"name": ".config",
			"source": "./src/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "copy",
			"name": "Wallpapers",
			"source": "./src/",
			"target": "{{ .User.home }}/Pictures/"
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
		},
		{
			"action": "copy",
			"elevated": true,
			"name": "Alacritty.svg",
			"source": "./src/desktop/",
			"target": "/usr/share/pixmaps/"
		}
	]
}
