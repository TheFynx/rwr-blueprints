// Archcraft-specific packages not in the shared Arch base (imported from Common).
{
	"packages": [
		{
			"import": "../../Common/packages/arch/base-pacman.cue"
		},
		{
			"action": "install",
			"names": [
				"p7zip",
				"brave-browser"
			],
			"package_manager": "pacman"
		}
	]
}
