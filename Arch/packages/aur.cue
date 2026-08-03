// Arch-specific AUR packages not in Archcraft; base AUR set imported from Common.
{
	"packages": [
		{
			"import": "../../Common/packages/arch/base-aur.cue"
		},
		{
			"action": "install",
			"names": [
				"nvm",
				"gosec",
				"protontricks",
				"protonup-qt-bin",
				"opencl-amd",
				"r8126-dkms",
				"nsis",
				"uno-calculator-bin",
				"amdgpu_top",
				"bambustudio-appimage",
				"openaudible-bin",
				"pince",
				"handbrake-full",
				"keybase-bin"
			],
			"package_manager": "paru"
		}
	]
}
