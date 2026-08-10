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
				"lib32-vulkan-radeon",
				"lib32-vulkan-icd-loader",
				"vulkan-icd-loader",
				"vulkan-mesa-layers",
				"lib32-mesa",
				"vulkan-radeon",
				"mesa-utils",
				"lib32-mpg123",
				"gameconqueror",
				"xdotool",
				"yad",
				"xorg-xwininfo",
				"webkit2gtk-4.1",
				"lib32-glibc",
				"handbrake",
				"radeontop",
				"amdgpu_top",
				"ollama-rocm",
				"opencl-amd"
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
