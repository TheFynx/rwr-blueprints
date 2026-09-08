// Omarchy tree: the opinionated Arch + Hyprland distro gets its own tree
// because it owns most of ~/.config itself. This tree overlays only what is
// ours (keybinds, pinned nvim) and imports the shared Arch package bases.
// Matched by distro: omarchy (ID=omarchy, ID_LIKE=arch).
{
	"blueprints": {
		"format": "cue",
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"order": ["scripts", "packages", "users", "files", "services", "git"]
	}
}
