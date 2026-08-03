// Desktop/laptop extras shared by the Arch-family machines: AI/ML tools,
// applications, additional tooling. Gated by the desktop profile.
{
	"profiles": {
		"desktop": {
			"packages": [
				{
					"action": "install",
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
				}
			]
		},
		"laptop": {
			"packages": [
				{
					"action": "install",
					"names": [
						"tlp",
						"powertop"
					],
					"package_manager": "pacman"
				}
			]
		}
	}
}
