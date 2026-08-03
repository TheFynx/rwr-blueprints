{
	"directories": [
		{
			"action": "copy",
			"name": ".config",
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
			"source": "../../Common/linux-dotfiles/",
			"target": "{{ .User.home }}/"
		}
	]
}
