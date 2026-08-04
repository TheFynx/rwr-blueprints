{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": "."
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	]
}
