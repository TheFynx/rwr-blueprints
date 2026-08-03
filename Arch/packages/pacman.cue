// Arch-specific pacman packages not in Archcraft; base + desktop come in
// via Common imports (profiles: desktop gates the workstation extras).
{
	"packages": [
		{
			"action": "remove",
			"names": [
				"firefox",
				"alacritty",
				"node-lts-jod"
			],
			"package_manager": "pacman"
		},
		{
			"import": "../../Common/packages/arch/base-pacman.cue"
		},
		{
			"import": "../../Common/packages/arch/desktop-laptop.cue",
			"profiles": ["desktop"]
		},
		{
			"action": "install",
			"names": [
				"github-cli",
				"git-delta",
				"7zip",
				"tldr",
				"gnome-disk-utility",
				"tailscale",
				"dagger",
				"ttf-dejavu",
				"ttf-liberation",
				"noto-fonts",
				"noto-fonts-emoji",
				"ghostty",
				"ghostty-shell-integration",
				"mediainfo",
				"amf-headers"
			],
			"package_manager": "pacman"
		}
	]
}
