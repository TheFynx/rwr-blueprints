{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",

		// The default order runs scripts before configuration, which means the
		// com.apple.dock keys in configuration/defaults.cue are written *after*
		// scripts/dock.cue restarts the Dock - so on a fresh machine they only
		// take effect on the run after next. Swapping the two lands everything
		// in one pass.
		//
		// This list is exhaustive on purpose: rwr runs only the processors named
		// here, it does not fill in the ones left out, so an omission is a
		// silently skipped blueprint directory.
		"order": [
			"repositories",
			"packages",
			"ssh_keys",
			"users",
			"files",
			"fonts",
			"services",
			"git",
			"configuration",
			"scripts",
		]
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "brew"
		},
		{
			"action": "install",
			"name": "cargo"
		}
	]
}
