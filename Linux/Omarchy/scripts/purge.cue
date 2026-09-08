// Rename-migration purges (shelly -> shelly-bin, appimagelauncher ->
// appimagelauncher-beta-bin, protonup-qt -> protonup-qt-bin) must run BEFORE
// the packages processor, so the shared purge script is referenced here too -
// same script, cross-tree source like the nvim pin above.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "purge-defaults.sh",
			"source": "../../Arch/scripts/"
		}
	]
}
