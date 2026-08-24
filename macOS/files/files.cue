{
	"directories": [
		{
			"action":   "copy"
			"elevated": true
			"group":    "admin"
			"name":     ".config"
			"owner":    "{{ .User.username }}"
			"source":   "./src/"
			"target":   "{{ .User.home }}/"
		},
		// Alfred stores its preferences in a directory bundle. Treating this as
		// a file makes the files processor try to open the target directory as a
		// regular file.
		{
			"action":   "copy"
			"elevated": false
			"name":     "Alfred.alfredpreferences"
			"source":   "./src/Library/Application Support/Alfred/"
			"target":   "{{ .User.home }}/Library/Application Support/Alfred/"
		},
	]
	"files": [
		{
			"action": "copy"
			"names": [
				".aliases",
				".exports",
				".functions",
				".gitignore",
			]
			"source": "./src/dotFiles/"
			"target": "{{ .User.home }}/"
		},
		// kanata-tray autostart at login. RunAtLoad plist; the tray then autoruns
		// the default kanata preset through the kanata-sudo.sh shim.
		{
			"action": "copy"
			"name":   "com.rszyma.kanata-tray.plist"
			"source": "./src/.config/kanata-tray/"
			"target": "{{ .User.home }}/Library/LaunchAgents/"
		},
		// Rectangle window-manager keybinds and the macOS system hotkey map are
		// whole plists - nested dicts of keyCode/modifierFlags per binding - so
		// they cannot be macos_defaults scalar writes. They land in a staging
		// directory here and scripts/preferences.cue imports them, because a
		// plist dropped straight into ~/Library/Preferences is ignored: cfprefsd
		// caches the old contents in memory and overwrites the file on exit.
		{
			"action": "copy"
			"names": [
				"com.knollsoft.Rectangle.plist",
				"com.apple.symbolichotkeys.plist",
			]
			"source": "./src/Library/Preferences/"
			"target": "{{ .User.home }}/.local/share/rwr/preferences/"
		},
		// VSCode settings, keybindings and MCP server list. These are the real
		// VSCode config - its plist holds only window geometry and Sparkle state,
		// so it is deliberately not captured. mcp.json references its API key
		// through an ${input:} prompt, so no secret is committed here.
		{
			"action": "copy"
			"names": [
				"settings.json",
				"keybindings.json",
				"mcp.json",
			]
			"source": "./src/Library/Application Support/Code/User/"
			"target": "{{ .User.home }}/Library/Application Support/Code/User/"
		},
		// Alfred's real preferences live in the .alfredpreferences bundle, not the
		// app's plist. Only preferences/ and workflows/ are tracked: Databases/
		// (157M search index), Assistant/ and Automation/ are machine-local caches
		// that rebuild themselves. Alfred owns Cmd+Space here - the Spotlight
		// binding it replaces is disabled in the symbolichotkeys plist.
		//
		// The preferences/local/<hash>/ directory is keyed by this machine's
		// localhash from prefs.json, so on a different machine Alfred ignores it
		// and writes its own; the non-local prefs still apply.
		// The blanket .config copy above delivers the shim without its exec bit
		// guaranteed - enforce it.
		{
			"action": "chmod"
			"mode":   "0755"
			"name":   "kanata-sudo.sh"
			"target": "{{ .User.home }}/.config/kanata/kanata-sudo.sh"
		},
		// The standalone VirtualHID package does not manage its daemon at boot,
		// so install the system LaunchDaemon explicitly.
		{
			"action":   "create"
			"content":  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n  <key>Label</key>\n  <string>org.pqrs.Karabiner-VirtualHIDDevice-Daemon</string>\n  <key>ProgramArguments</key>\n  <array>\n    <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>\n  </array>\n  <key>RunAtLoad</key>\n  <true/>\n  <key>KeepAlive</key>\n  <true/>\n</dict>\n</plist>\n"
			"elevated": true
			"group":    "wheel"
			"mode":     "0644"
			"name":     "org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"
			"owner":    "root"
			"target":   "/Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"
		},
	]
	"templates": [
		{
			"action": "create"
			"name":   ".path"
			"source": "./src/dotFiles/"
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create"
			"name":   ".bashrc"
			"source": "./src/dotFiles/"
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create"
			"name":   ".profile"
			"source": "./src/dotFiles/"
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create"
			"name":   ".gitconfig"
			"source": "./src/dotFiles/"
			"target": "{{ .User.home }}/"
			"variables": {
				"gitEmail":   "levi@fynx.me"
				"gitName":    "Levi Smith"
				"signingKey": "8BF6E0074D7B228F9AF2BC76235C8EE4DF4F8767"
			}
		},
		{
			"action": "create"
			"name":   "config"
			"source": "./src/ssh/"
			"target": "{{ .User.home }}/.ssh/"
		},
		// kanata-tray reads its config from ~/Library/Application Support, not
		// ~/.config, so the blanket .config copy above lands a copy it ignores;
		// this template delivers the real one. Rendered as a template because
		// kanata_config points at an absolute home path. Source lives under
		// src/.config/ so rwr validate's blueprint walk skips it.
		{
			"action": "create"
			"name":   "kanata-tray.toml"
			"source": "./src/.config/kanata-tray/"
			"target": "{{ .User.home }}/Library/Application Support/kanata-tray/"
		},
		// Passwordless sudo for the kanata binary only - the tray's shim runs
		// `sudo -n kanata`, and kanata needs root for the virtual HID keyboard.
		{
			"action":   "create"
			"elevated": true
			"group":    "wheel"
			"mode":     "0440"
			"name":     "kanata.sudoers"
			"owner":    "root"
			"source":   "./src/.config/kanata/"
			"target":   "/etc/sudoers.d/kanata"
		},
		// Same shared fish setup Arch gets (Common/fish). config.fish is rendered,
		// not copied: it branches on .System.os for the homebrew prefix and the
		// macOS network aliases.
		{
			"action": "create"
			"name":   "config.fish"
			"source": "../../Common/fish/"
			"target": "{{ .User.home }}/.config/fish/"
		},
		{
			"action": "copy"
			"name":   "starship.toml"
			"source": "../../Common/fish/"
			"target": "{{ .User.home }}/.config/"
		},
		{
			"action": "copy"
			"name":   "fish_variables"
			"source": "../../Common/fish/"
			"target": "{{ .User.home }}/.config/fish/"
		},
		// The wine/proton/steam helpers Arch ships (dmm, _steamapps, steamid,
		// winedpi, winerun) are deliberately absent - protontricks is Linux-only.
		{
			"action": "copy"
			"names": [
				"dclean.fish",
				"digga.fish",
				"fs.fish",
				"git-check.fish",
				"isup.fish",
				"ls.fish",
				"man.fish",
			]
			"source": "../../Common/fish/functions/"
			"target": "{{ .User.home }}/.config/fish/functions/"
		},
	]
}
