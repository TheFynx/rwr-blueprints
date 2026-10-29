{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": "."
	},
	// The account the users and bootstrap blueprints shape, defaulting to
	// levi. Override per machine with RWR_USERNAME=bob (env beats default).
	"variables": {
		"userDefined": {
			"USERNAME": "levi"
		}
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "chocolatey"
		},
		{
			"action": "install",
			"name": "scoop"
		},
		{
			"action": "install",
			"name": "cargo"
		}
	]
}
