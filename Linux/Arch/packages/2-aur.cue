// Arch workstation AUR packages; base AUR set imported from Common.
// Keybase removed on purpose: GPG keys move to a non-Keybase flow (see README).
// Names here that also exist in chaotic-aur (protonup-qt, pix, maplemono-ttf,
// needrestart) install as repo binaries on PrismLinux and as AUR builds
// elsewhere - plain pacman targets fail wherever chaotic is absent, which is
// why they live in the yay list.
{
	"packages": [
		{
			"import": "../../../Common/packages/arch/base-aur.cue"
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
				"pince-git",
				"protonup-qt-bin",
				"pix",
				"maplemono-ttf",
				"needrestart",
				"claude-code",
				"opencode",
				"zcode-bin",
				"shelly-bin",
				"appimagelauncher-beta-bin"
			],
			"package_manager": "yay"
		}
	]
}
