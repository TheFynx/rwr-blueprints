// One repo, every machine: rwr picks the configuration whose matchers fit
// the detected OS; force one explicitly with --config-name.
{
	"configurations": [
		{
			"name": "arch",
			"init": "Arch/init.cue",
			"os": "linux",
			"distro": "arch"
		},
		{
			"name": "archcraft",
			"init": "Archcraft/init.cue",
			"os": "linux",
			"distro": "archcraft"
		},
		{
			"name": "popos",
			"init": "PopOS/init.cue",
			"os": "linux",
			"distro": "pop"
		},
		{
			"name": "openmandriva",
			"init": "OpenMandriva/init.cue",
			"os": "linux",
			"distro": "openmandriva"
		},
		{
			"name": "macos",
			"init": "macOS/init.cue",
			"os": "darwin"
		},
		{
			"name": "windows",
			"init": "Windows/init.cue",
			"os": "windows"
		}
	]
}
