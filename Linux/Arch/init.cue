{
	"blueprints": {
		"format": "cue",
		except: ["credentials"],
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"includes": ["../../Common/credentials/gpg.cue"],
		// Exhaustive list of processors to run, in this order: rwr runs only
		// the processors named here and skips the rest silently. Scripts run
		// first so the rename-migration purges land before package installs.
		// Package files carry numeric prefixes (1-pacman.cue, 2-aur.cue) so
		// walk order keeps repo packages ahead of AUR builds.
		"order": ["scripts", "packages", "users", "files", "services", "git"]
	},
	// The account the users blueprints shape, defaulting to levi. Override it
	// per machine with RWR_USERNAME=bob: an env var RWR_USERNAME lands in
	// .UserDefined.USERNAME and beats this default.
	"variables": {
		"userDefined": {
			"USERNAME": "levi"
		}
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	],
}
