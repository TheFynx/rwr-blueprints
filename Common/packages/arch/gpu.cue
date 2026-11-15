// GPU-vendor stacks, one entry per vendor: pick exactly one via --profile
// (radeon on this workstation, nvidia elsewhere). Generic graphics - the
// loader and mesa layers - stay in desktop-laptop.cue; these add the vendor
// driver and vendor tooling on top.
{
	"packages": [
		{
			"action": "install",
			"profiles": ["radeon"],
			"names": [
				"vulkan-radeon",
				"lib32-vulkan-radeon",
				"radeontop",
				"amdgpu_top"
			],
			"package_manager": "pacman"
		},
		// Ollama is opt-in, not a default: the ROCm build suits the radeon
		// machine; on an nvidia box swap this entry for ollama-cuda before
		// naming the profile there.
		{
			"action": "install",
			"profiles": ["ai"],
			"names": [
				"ollama-rocm"
			],
			"package_manager": "pacman"
		},
		{
			"action": "install",
			"profiles": ["nvidia"],
			"names": [
				"nvidia-dkms",
				"nvidia-utils",
				"lib32-nvidia-utils",
				"nvidia-settings"
			],
			"package_manager": "pacman"
		}
	]
}
