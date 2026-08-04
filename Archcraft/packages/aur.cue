// Archcraft-specific AUR packages; base AUR set imported from Common.
{
	"packages": [
		{
			"import": "../../Common/packages/arch/base-aur.cue"
		},
		{
			"action": "install",
			"names": [
				"nvm",
				"hoard"
			],
			"package_manager": "yay"
		}
	]
}
