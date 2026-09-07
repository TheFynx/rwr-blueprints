{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		// Exhaustive list of processors to run, in this order: rwr runs only
		// the processors named here and skips the rest silently. Package files
		// carry numeric prefixes (1-pacman.cue, 2-aur.cue) so walk order keeps
		// repo packages ahead of AUR builds.
		"order": ["packages", "users", "scripts", "files", "services", "git"]
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	]
}
