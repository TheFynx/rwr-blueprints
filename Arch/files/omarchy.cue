// Omarchy (Hyprland) user overlay, gated behind the omarchy profile. Deploys
// only the personal keybind file into ~/.config/hypr/ - Omarchy owns the rest
// of ~/.config and stays upgrade-safe (its bar/shell.json is deliberately NOT
// managed here; see README for the tray-pinning note).
//
// On VirtualBox hosts, Omarchy needs VBoxVGA + 3D acceleration off + 128MB
// VRAM or Hyprland black-screens; see README before first boot.
{
	"directories": [
		{
			"action": "copy",
			"name": ".config",
			"profiles": ["omarchy"],
			"source": "./omarchy-src/",
			"target": "{{ .User.home }}/"
		}
	]
}
