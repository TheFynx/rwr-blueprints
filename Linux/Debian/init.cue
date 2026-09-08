// Debian/Ubuntu tree: standard setup translated to apt. Shared content lives
// in Common (packages/debian, scripts/debian, files) - this tree is a thin
// selector. Matched by distro ID (debian / ubuntu).
{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"order": ["packages", "users", "scripts", "files", "services", "git"]
	}
}
