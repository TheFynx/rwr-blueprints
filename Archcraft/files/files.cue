{
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
