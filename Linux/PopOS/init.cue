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
			"name": "brew"
		},
		{
			"action": "install",
			"name": "cargo"
		},
		{
			"action": "install",
			"name": "gnome-extensions"
		}
	]
}
