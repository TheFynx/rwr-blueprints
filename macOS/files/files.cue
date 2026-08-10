{
	"directories": [
		{
			"action": "copy",
			"elevated": true,
			"group": "admin",
			"name": ".config",
			"owner": "{{ .User.username }}",
			"source": "./src/",
			"target": "{{ .User.home }}/"
		}
	],
	"files": [
		{
			"action": "copy",
			"names": [
				".aliases",
				".exports",
				".functions",
				".gitignore"
			],
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		// kanata-tray autostart at login. RunAtLoad plist; the tray then autoruns
		// the default kanata preset through the kanata-sudo.sh shim.
		{
			"action": "copy",
			"name": "com.rszyma.kanata-tray.plist",
			"source": "./src/.config/kanata-tray/",
			"target": "{{ .User.home }}/Library/LaunchAgents/"
		},
		// The blanket .config copy above delivers the shim without its exec bit
		// guaranteed - enforce it.
		{
			"action": "chmod",
			"mode": "0755",
			"name": "kanata-sudo.sh",
			"target": "{{ .User.home }}/.config/kanata/kanata-sudo.sh"
		}
	],
	"templates": [
		{
			"action": "create",
			"name": ".path",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".bashrc",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".profile",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "create",
			"name": ".gitconfig",
			"source": "./src/dotFiles/",
			"target": "{{ .User.home }}/",
			"variables": {
				"gitEmail": "levi@fynx.me",
				"gitName": "Levi Smith",
				"signingKey": "8BF6E0074D7B228F9AF2BC76235C8EE4DF4F8767"
			}
		},
		{
			"action": "create",
			"name": "config",
			"source": "./src/ssh/",
			"target": "{{ .User.home }}/.ssh/"
		},
		// kanata-tray reads its config from ~/Library/Application Support, not
		// ~/.config, so the blanket .config copy above lands a copy it ignores;
		// this template delivers the real one. Rendered as a template because
		// kanata_config points at an absolute home path. Source lives under
		// src/.config/ so rwr validate's blueprint walk skips it.
		{
			"action": "create",
			"name": "kanata-tray.toml",
			"source": "./src/.config/kanata-tray/",
			"target": "{{ .User.home }}/Library/Application Support/kanata-tray/"
		},
		// Passwordless sudo for the kanata binary only - the tray's shim runs
		// `sudo -n kanata`, and kanata needs root for the virtual HID keyboard.
		{
			"action": "create",
			"elevated": true,
			"group": "wheel",
			"mode": "0440",
			"name": "kanata.sudoers",
			"owner": "root",
			"source": "./src/.config/kanata/",
			"target": "/etc/sudoers.d/kanata"
		},
		// Same shared fish setup Arch gets (Common/fish). config.fish is rendered,
		// not copied: it branches on .System.os for the homebrew prefix and the
		// macOS network aliases.
		{
			"action": "create",
			"name": "config.fish",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/fish/"
		},
		{
			"action": "copy",
			"name": "starship.toml",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/"
		},
		{
			"action": "copy",
			"name": "fish_variables",
			"source": "../../Common/fish/",
			"target": "{{ .User.home }}/.config/fish/"
		},
		// The wine/proton/steam helpers Arch ships (dmm, _steamapps, steamid,
		// winedpi, winerun) are deliberately absent - protontricks is Linux-only.
		{
			"action": "copy",
			"names": [
				"dclean.fish",
				"digga.fish",
				"fs.fish",
				"git-check.fish",
				"isup.fish",
				"ls.fish",
				"man.fish"
			],
			"source": "../../Common/fish/functions/",
			"target": "{{ .User.home }}/.config/fish/functions/"
		}
	]
}
