{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": "."
	},
	// The account the users blueprints shape, defaulting to levi.
	// Override per machine with RWR_USERNAME=bob (env beats this default).
	"variables": {
		"userDefined": {
			"USERNAME": "levi"
		}
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
