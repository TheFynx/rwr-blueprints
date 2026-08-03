// Shared checkouts, every machine. HTTPS so a fresh machine clones before
// its SSH key exists on GitHub.
{
	"git": [
		{
			"action": "clone",
			"name": "rwr",
			"path": "{{ .User.home }}/git/fynxlabs/rwr",
			"private": false,
			"url": "https://github.com/FynxLabs/rwr.git"
		},
		{
			"action": "clone",
			"name": "rwr-blueprints",
			"path": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"private": false,
			"url": "https://github.com/TheFynx/rwr-blueprints.git"
		},
		{
			"action": "clone",
			"name": "nvim",
			"path": "{{ .User.home }}/.config/nvim",
			"private": false,
			"url": "https://github.com/AstroNvim/template"
		}
	]
}
