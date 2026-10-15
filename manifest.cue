// One repo, every machine: rwr picks the configuration whose matchers fit the
// detected OS; force one explicitly with --config-name.
//
// Omarchy and Animation are both selectable on Omarchy. The ordinary Omarchy
// entry is the headless default; --config-name animation explicitly selects
// the NVIDIA animation workstation. Interactive runs show both options.
{
	"configurations": [
		{
			"name": "arch",
			"init": "Linux/Arch/init.cue",
			"os": "linux",
			"family": "arch"
		},
		{
			"name": "omarchy",
			"default": true,
			"init": "Linux/Omarchy/init.cue",
			"os": "linux",
			"distro": "omarchy"
		},
		{
			"name": "animation",
			"init": "Linux/Animation/init.cue",
			"os": "linux",
			"distro": "omarchy"
		},
		{
			"name": "debian",
			"init": "Linux/Debian/init.cue",
			"os": "linux",
			"distro": "debian"
		},
		{
			"name": "ubuntu",
			"init": "Linux/Ubuntu/init.cue",
			"os": "linux",
			"distro": "ubuntu"
		},
		{
			"name": "popos",
			"init": "Linux/PopOS/init.cue",
			"os": "linux",
			"distro": "pop"
		},
		{
			"name": "openmandriva",
			"init": "Linux/OpenMandriva/init.cue",
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
