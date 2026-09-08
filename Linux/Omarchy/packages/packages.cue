// Same workstation package set as the general Arch tree - verified clean on
// Omarchy 4.0.2 (the distro-native variants like mise-bin/tldr satisfy the
// conflicting names; see Linux/Arch/packages for the split).
{
	"packages": [
		{
			"import": "../../Arch/packages/1-pacman.cue"
		},
		{
			"import": "../../Arch/packages/2-aur.cue"
		}
	]
}
