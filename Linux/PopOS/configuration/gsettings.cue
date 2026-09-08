{
	"configurations": [
		{
			"action": "set",
			"name": "Set Eddy settings",
			"schema": "com.github.donadigo.eddy",
			"settings": {
				"mime-types": [
					"application/vnd.debian.binary-package",
					"application/x-deb"
				],
				"window-x": 0,
				"window-y": 32
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set System76 HiDPI settings",
			"schema": "com.system76.hidpi",
			"settings": {
				"enable": false,
				"mode": "hidpi"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop background settings",
			"schema": "org.gnome.desktop.background",
			"settings": {
				"color-shading-type": "solid",
				"primary-color": "#000000000000",
				"secondary-color": "#000000000000"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop input sources",
			"schema": "org.gnome.desktop.input-sources",
			"settings": {
				"current": 0,
				"per-window": false,
				"sources": "[('xkb', 'us')]"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop interface settings",
			"schema": "org.gnome.desktop.interface",
			"settings": {
				"color-scheme": "prefer-dark",
				"show-battery-percentage": true
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop media handling",
			"schema": "org.gnome.desktop.media-handling",
			"settings": {
				"autorun-never": true,
				"autorun-x-content-ignore": [
					"x-content/audio-cdda",
					"x-content/video-dvd",
					"x-content/audio-player"
				],
				"autorun-x-content-open-folder": [
					"x-content/image-dcf"
				],
				"autorun-x-content-start-app": [
					"x-content/unix-software",
					"x-content/ostree-repository"
				]
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop peripherals keyboard settings",
			"schema": "org.gnome.desktop.peripherals.keyboard",
			"settings": {
				"numlock-state": true
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop peripherals touchpad settings",
			"schema": "org.gnome.desktop.peripherals.touchpad",
			"settings": {
				"two-finger-scrolling-enabled": true
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop privacy settings",
			"schema": "org.gnome.desktop.privacy",
			"settings": {
				"report-technical-problems": false
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop session settings",
			"schema": "org.gnome.desktop.session",
			"settings": {
				"idle-delay": 900
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop window manager keybindings",
			"schema": "org.gnome.desktop.wm.keybindings",
			"settings": {
				"activate-window-menu": [
					"\u003cPrimary\u003eHome"
				],
				"move-to-workspace-1": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eHome",
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eexclam"
				],
				"move-to-workspace-2": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eat"
				],
				"move-to-workspace-3": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003enumbersign"
				],
				"move-to-workspace-4": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003edollar"
				],
				"move-to-workspace-down": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eDown"
				],
				"move-to-workspace-last": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eEnd"
				],
				"move-to-workspace-up": [
					"\u003cPrimary\u003e\u003cShift\u003e\u003cAlt\u003eUp"
				],
				"switch-applications": [
					"\u003cAlt\u003eTab"
				],
				"switch-applications-backward": [
					"\u003cShift\u003e\u003cAlt\u003eTab"
				],
				"switch-to-workspace-1": [
					"\u003cPrimary\u003e\u003cAlt\u003eHome",
					"\u003cPrimary\u003e\u003cAlt\u003eKP_1"
				],
				"switch-to-workspace-2": [
					"\u003cPrimary\u003e\u003cAlt\u003eKP_2"
				],
				"switch-to-workspace-3": [
					"\u003cPrimary\u003e\u003cAlt\u003eKP_3"
				],
				"switch-to-workspace-4": [
					"\u003cPrimary\u003e\u003cAlt\u003eKP_4"
				],
				"switch-to-workspace-down": [
					"\u003cPrimary\u003e\u003cAlt\u003eDown"
				],
				"switch-to-workspace-up": [
					"\u003cPrimary\u003e\u003cAlt\u003eUp"
				]
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME desktop window manager preferences",
			"schema": "org.gnome.desktop.wm.preferences",
			"settings": {
				"button-layout": "appmenu:minimize,maximize,close"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Evolution Data Server settings",
			"schema": "org.gnome.evolution-data-server",
			"settings": {
				"migrated": true,
				"network-monitor-gio-name": ""
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Gedit plugins settings",
			"schema": "org.gnome.gedit.plugins",
			"settings": {
				"active-plugins": [
					"filebrowser",
					"spell",
					"docinfo",
					"openlinks",
					"modelines",
					"sort"
				]
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Gedit file browser plugin settings",
			"schema": "org.gnome.gedit.plugins.filebrowser",
			"settings": {
				"root": "file:///",
				"tree-view": true,
				"virtual-root": "file:///media/levi/ExtDrive/Backups/Desktop"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Gedit preferences UI settings",
			"schema": "org.gnome.gedit.preferences.ui",
			"settings": {
				"show-tabs-mode": "auto"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Mutter settings",
			"schema": "org.gnome.mutter",
			"settings": {
				"edge-tiling": true,
				"experimental-features": [
					"x11-randr-fractional-scaling"
				],
				"overlay-key": "Super_L"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Mutter keybindings",
			"schema": "org.gnome.mutter.keybindings",
			"settings": {
				"toggle-tiled-left": [
					"\u003cSuper\u003eLeft"
				],
				"toggle-tiled-right": [
					"\u003cSuper\u003eRight"
				]
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Nautilus preferences",
			"schema": "org.gnome.nautilus.preferences",
			"settings": {
				"default-folder-viewer": "icon-view",
				"search-filter-time-type": "last_modified"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Nautilus window state",
			"schema": "org.gnome.nautilus.window-state",
			"settings": {
				"initial-size": "(959, 789)",
				"maximized": false
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Power Manager settings",
			"schema": "org.gnome.power-manager",
			"settings": {
				"info-history-type": "charge",
				"info-last-device": "/org/freedesktop/UPower/devices/mouse_hidpp_battery_0",
				"info-stats-type": "discharge-accuracy"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME settings daemon media keys",
			"schema": "org.gnome.settings-daemon.plugins.media-keys",
			"settings": {
				"calculator": [
					"Calculator"
				],
				"custom-keybindings": [
					"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
				],
				"next": [
					"AudioNext"
				],
				"play": [
					"AudioPlay"
				],
				"previous": [
					"AudioPrev"
				],
				"screensaver": [
					"\u003cPrimary\u003e\u003cAlt\u003el"
				],
				"terminal": [],
				"volume-down": [
					"AudioLowerVolume"
				],
				"volume-mute": [
					"AudioMute"
				],
				"volume-up": [
					"AudioRaiseVolume"
				]
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set custom keybinding for Alacritty",
			"schema": "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/",
			"settings": {
				"binding": "\u003cSuper\u003et",
				"command": "/home/levi/.cargo/bin/alacritty",
				"name": "Alacritty"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME settings daemon power settings",
			"schema": "org.gnome.settings-daemon.plugins.power",
			"settings": {
				"sleep-inactive-ac-timeout": 1800,
				"sleep-inactive-ac-type": "nothing",
				"sleep-inactive-battery-timeout": 1500,
				"sleep-inactive-battery-type": "suspend"
			},
			"tool": "gsettings"
		},
		{
			"action": "set",
			"name": "Set GNOME Shell settings",
			"schema": "org.gnome.shell",
			"settings": {
				"disable-user-extensions": false,
				"disabled-extensions": [
					"cosmic-dock@system76.com"
				],
				"enabled-extensions": [
					"ding@rastersoft.com",
					"pop-cosmic@system76.com",
					"pop-shell@system76.com",
					"system76-power@system76.com",
					"ubuntu-appindicators@ubuntu.com",
					"popx11gestures@system76.com",
					"cosmic-workspaces@system76.com",
					"arcmenu@arcmenu.com",
					"sound-output-device-chooser@kgshank.net",
					"openweather-extension@jenslody.de",
					"dash-to-panel@jderose9.github.com"
				],
				"favorite-apps": [
					"org.gnome.Nautilus.desktop",
					"brave-browser.desktop"
				]
			},
			"tool": "gsettings"
		}
	]
}
