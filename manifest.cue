// One repo, every machine: rwr picks the configuration whose matchers fit the
// detected OS; force one explicitly with --config-name.
//
// Matcher notes (rwr matches distro against /etc/os-release ID, family against
// a hardcoded distro-family map, and MULTIPLE matches are a headless error -
// every distro must match exactly one entry, so prefer distro: over family:
// whenever the ID is known):
//   arch      family: arch   → PrismLinux, Arch, EndeavourOS, CachyOS, ...
//   omarchy   distro: omarchy→ ID=omarchy is NOT in the arch family map, so
//                            it only matches this entry
//   debian    distro: debian → not family: debian, or ubuntu machines would
//                            double-match
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
			"init": "Linux/Omarchy/init.cue",
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
