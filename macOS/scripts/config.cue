{
	"scripts": [
		{
			"action": "run",
			// tmutil needs Full Disk Access for the invoking terminal, and macOS
			// has no CLI/API to grant TCC permissions (MDM profiles only). When
			// it fails with the FDA error (exit 80), open the exact Settings
			// pane, say what to do, and fail so the run records it honestly -
			// rerun after granting and this converges.
			"content": "#!/bin/bash\nif sudo tmutil disable; then\n  exit 0\nfi\nrc=$?\nif [ \"$rc\" -eq 80 ]; then\n  echo 'Time Machine disable needs Full Disk Access for your terminal.' >&2\n  echo 'Opening System Settings > Privacy & Security > Full Disk Access -' >&2\n  echo 'add your terminal app, then rerun rwr.' >&2\n  open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles' || true\nfi\nexit \"$rc\"\n",
			"elevated": true,
			"name": "disable_time_machine"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo systemsetup -setrestartfreeze on\n",
			"elevated": true,
			"name": "restart_on_freeze"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo pmset -a displaysleep 30\n",
			"elevated": true,
			"name": "display_sleep_time"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo pmset -c sleep 0\n",
			"elevated": true,
			"name": "no_sleep_on_ac"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo pmset -b sleep 5\n",
			"elevated": true,
			"name": "sleep_time_on_battery"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo pmset -a standbydelay 86400\n",
			"elevated": true,
			"name": "set_standby_delay"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo systemsetup -setcomputersleep off\n",
			"elevated": true,
			"name": "disable_computer_sleep"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nsudo pmset -a hibernatemode 0\n",
			"elevated": true,
			"name": "set_hibernate_mode"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\ndefaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true\n",
			"name": "expand_file_info_panes"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nlaunchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist\n",
			"name": "disable_itunes_media_keys"
		}
	]
}
