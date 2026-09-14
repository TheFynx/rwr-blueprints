// Omarchy tree: the opinionated Arch + Hyprland distro gets its own tree
// because it owns most of ~/.config itself. This tree overlays only what is
// ours (keybinds, pinned nvim) and imports the shared Arch package bases.
// Matched by distro: omarchy (ID=omarchy, ID_LIKE=arch).
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
		"order": ["ssh_keys", "scripts", "packages", "users", "files", "services", "git"]
	},
}
