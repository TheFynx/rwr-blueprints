{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		// Listed files run first, in this order; the rest follow in walk
		// order. Repo packages install via pacman before any AUR builds.
		"order": ["packages/pacman.cue", "packages/aur.cue"]
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	]
}
