{
	"scripts": [
		{
			"action": "run"
			// tmutil needs Full Disk Access for the invoking terminal, and macOS
			// has no CLI/API to grant TCC permissions (MDM profiles only). When
			// it fails with the FDA error (exit 80), open the exact Settings
			// pane, say what to do, and fail so the run records it honestly -
			// rerun after granting and this converges.
			"content":  "#!/bin/bash\nsudo tmutil disable\nrc=$?\nif [ \"$rc\" -eq 0 ]; then\n  exit 0\nfi\nif [ \"$rc\" -eq 80 ]; then\n  echo 'Time Machine disable needs Full Disk Access for your terminal.' >&2\n  echo 'Opening System Settings > Privacy & Security > Full Disk Access -' >&2\n  echo 'add your terminal app, then rerun rwr.' >&2\n  open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles' || true\nfi\nexit \"$rc\"\n"
			"elevated": true
			"name":     "disable_time_machine"
		},
		{
			"action": "run"
			// Keep the display timeout below system sleep on battery; pmset warns
			// (and macOS may behave unpredictably) when display sleep is longer.
			"content":  "#!/bin/bash\nsudo pmset -c displaysleep 30\nsudo pmset -b displaysleep 3\n"
			"elevated": true
			"name":     "display_sleep_time"
		},
		{
			"action":   "run"
			"content":  "#!/bin/bash\nsudo pmset -c sleep 0\n"
			"elevated": true
			"name":     "no_sleep_on_ac"
		},
		{
			"action":   "run"
			"content":  "#!/bin/bash\nsudo pmset -b sleep 5\n"
			"elevated": true
			"name":     "sleep_time_on_battery"
		},
		{
			"action":   "run"
			"content":  "#!/bin/bash\nsudo pmset -a standbydelay 86400\n"
			"elevated": true
			"name":     "set_standby_delay"
		},
		{
			"action":   "run"
			"content":  "#!/bin/bash\nsudo pmset -a hibernatemode 0\n"
			"elevated": true
			"name":     "set_hibernate_mode"
		},
		{
			"action":  "run"
			"content": "#!/bin/bash\ndefaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true\n"
			"name":    "expand_file_info_panes"
		},
		// WindowManager caches the desktop-widget, desktop-icon and Stage Manager
		// keys in memory and rewrites its plist on exit, so the defaults set in
		// configuration/defaults.cue do not take hold until it restarts. It comes
		// straight back up under launchd.
		{
			"action":  "run"
			"content": "#!/bin/bash\nkillall WindowManager || true\n"
			"name":    "restart_window_manager"
		},
		// Same story for Finder and the desktop-icon / view-style keys.
		{
			"action":  "run"
			"content": "#!/bin/bash\nkillall Finder || true\n"
			"name":    "restart_finder"
		},
		// SystemUIServer owns the menu bar clock keys.
		{
			"action":  "run"
			"content": "#!/bin/bash\nkillall SystemUIServer || true\n"
			"name":    "restart_system_ui_server"
		},
	]
}
