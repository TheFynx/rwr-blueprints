// Arch workstation AUR packages; base AUR set imported from Common.
// Keybase removed on purpose: GPG keys move to a non-Keybase flow (see README).
// protonup-qt, tealdeer and amdgpu_top come from pacman repos / gpu.cue now -
// the *-bin AUR builds failed on every run.
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
				"r8126-dkms",
				"nsis",
				"uno-calculator-bin",
				"bambustudio-appimage",
				"openaudible-bin",
				"pince",
				"claude-code",
				"claude-desktop-bin",
				"opencode",
				"zcode-bin",
				"shelly",
				"appimagelauncher"
			],
			"package_manager": "yay"
		}
	]
}
