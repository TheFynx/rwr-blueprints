// Desktop/laptop extras shared by the Arch-family machines: AI/ML tools,
// applications, additional tooling. Gated per-entry by the desktop and
// laptop profiles (rwr's schema is a profiles list on each item, not a
// top-level profile grouping).
{
	"packages": [
		{
			"action": "install",
			"profiles": ["desktop"],
			"names": [
				"vulkan-icd-loader",
				"lib32-vulkan-icd-loader",
				"vulkan-mesa-layers",
				"mesa-utils",
				"lib32-mesa",
				"lib32-mpg123",
				"lib32-glibc",
				"gameconqueror",
				"xdotool",
				"yad",
				"xorg-xwininfo",
				"webkit2gtk-4.1",
				"handbrake"
			],
			"package_manager": "pacman"
		},
		{
			"action": "install",
			"profiles": ["laptop"],
			"names": [
				"tlp",
				"powertop"
			],
			"package_manager": "pacman"
		}
	]
}
