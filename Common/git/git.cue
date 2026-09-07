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
		}
		// nvim/AstroNvim moved out of here: the unpinned rolling clone broke too
		// often. Arch now pins it to a template commit via scripts/nvim.cue.
		// macOS has no nvim entry right now - re-add pinned there when wanted.
	]
}
