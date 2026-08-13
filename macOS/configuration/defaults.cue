// macOS defaults: Activity Monitor, Finder, and app preferences via the
// defaults tool.
{
	"configurations": [
		{
			"action": "set",
			"domain": "com.apple.ActivityMonitor",
			"key": "IconType",
			"kind": "bool",
			"name": "Show the main window when launching Activity Monitor",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.ActivityMonitor",
			"key": "ShowCategory",
			"kind": "int",
			"name": "Show all processes in Activity Monitor",
			"tool": "macos_defaults",
			"value": 100
		},
		{
			"action": "set",
			"domain": "com.apple.ActivityMonitor",
			"key": "SortColumn",
			"kind": "string",
			"name": "Sort Activity Monitor results by CPU usage",
			"tool": "macos_defaults",
			"value": "CPUUsage"
		},
		{
			"action": "set",
			"domain": "com.apple.ActivityMonitor",
			"key": "SortDirection",
			"kind": "int",
			"name": "Set Activity Monitor sort direction",
			"tool": "macos_defaults",
			"value": 0
		},
		{
			"action": "set",
			"domain": "com.apple.SoftwareUpdate",
			"key": "AutomaticCheckEnabled",
			"kind": "bool",
			"name": "Enable the automatic update check",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.SoftwareUpdate",
			"key": "ScheduleFrequency",
			"kind": "int",
			"name": "Check for software updates daily",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "com.apple.SoftwareUpdate",
			"key": "AutomaticDownload",
			"kind": "int",
			"name": "Download newly available updates in background",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "com.apple.SoftwareUpdate",
			"key": "CriticalUpdateInstall",
			"kind": "int",
			"name": "Install System data files \u0026 security updates",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "minimize-to-application",
			"kind": "bool",
			"name": "Minimize windows into application icon",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "enable-spring-load-actions-on-all-items",
			"kind": "bool",
			"name": "Enable spring loading for all Dock items",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "show-process-indicators",
			"kind": "bool",
			"name": "Show indicator lights for open applications in the Dock",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "launchanim",
			"kind": "bool",
			"name": "Don't animate opening applications from the Dock",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "expose-animation-duration",
			"kind": "float",
			"name": "Speed up Mission Control animations",
			"tool": "macos_defaults",
			"value": 0.1
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "expose-group-by-app",
			"kind": "bool",
			"name": "Don't group windows by application in Mission Control",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "dashboard-in-overlay",
			"kind": "bool",
			"name": "Don't show Dashboard as a Space",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "mru-spaces",
			"kind": "bool",
			"name": "Don't automatically rearrange Spaces based on most recent use",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "autohide-delay",
			"kind": "float",
			"name": "Remove the auto-hiding Dock delay",
			"tool": "macos_defaults",
			"value": 0.5
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "autohide-time-modifier",
			"kind": "float",
			"name": "Remove the animation when hiding/showing the Dock",
			"tool": "macos_defaults",
			"value": 0
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "autohide",
			"kind": "bool",
			"name": "Automatically hide and show the Dock",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "showhidden",
			"kind": "bool",
			"name": "Make Dock icons of hidden applications translucent",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "show-recents",
			"kind": "bool",
			"name": "Don't show recent applications in Dock",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "orientation",
			"kind": "string",
			"name": "Put the Dock on the right edge",
			"tool": "macos_defaults",
			"value": "right"
		},
		// Bottom-right hot corner. 1 is the "disabled" slot macOS writes when a
		// corner is explicitly turned off, which is not the same as the key being
		// unset - Apple's default for this corner is Quick Note, so setting it is
		// what keeps a stray cursor from spawning notes.
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "wvous-br-corner",
			"kind": "int",
			"name": "Disable the bottom-right hot corner (no Quick Note)",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "wvous-br-modifier",
			"kind": "int",
			"name": "Clear the bottom-right hot corner modifier",
			"tool": "macos_defaults",
			"value": 0
		},
		{
			"action": "set",
			"domain": "com.apple.dock",
			"key": "no-bouncing",
			"kind": "bool",
			"name": "Allow Dock icons to bounce for attention",
			"tool": "macos_defaults",
			"value": false
		},
		// Desktop stays empty: no widgets, no icons, and no click-to-reveal. These
		// live in com.apple.WindowManager and need a WindowManager restart, which
		// the restart_window_manager script handles.
		{
			"action": "set",
			"domain": "com.apple.WindowManager",
			"key": "StandardHideWidgets",
			"kind": "bool",
			"name": "Hide desktop widgets",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.WindowManager",
			"key": "StandardHideDesktopIcons",
			"kind": "bool",
			"name": "Hide all desktop icons",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.WindowManager",
			"key": "EnableStandardClickToShowDesktop",
			"kind": "bool",
			"name": "Don't reveal the desktop when clicking the wallpaper",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.WindowManager",
			"key": "GloballyEnabled",
			"kind": "bool",
			"name": "Disable Stage Manager",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "AppleInterfaceStyle",
			"kind": "string",
			"name": "Use Dark mode",
			"tool": "macos_defaults",
			"value": "Dark"
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "AppleMiniaturizeOnDoubleClick",
			"kind": "bool",
			"name": "Don't minimize windows on title bar double-click",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.mouse.scaling",
			"kind": "float",
			"name": "Set mouse tracking speed",
			"tool": "macos_defaults",
			"value": 3.0
		},
		// Screenshots land in Documents rather than piling up on a Desktop that is
		// hidden anyway.
		{
			"action": "set",
			"domain": "com.apple.screencapture",
			"key": "location",
			"kind": "string",
			"name": "Save screenshots to ~/Documents",
			"tool": "macos_defaults",
			"value": "~/Documents/"
		},
		{
			"action": "set",
			"domain": "com.apple.screencapture",
			"key": "target",
			"kind": "string",
			"name": "Save screenshots as files, not to the clipboard",
			"tool": "macos_defaults",
			"value": "file"
		},
		{
			"action": "set",
			"domain": "com.apple.menuextra.clock",
			"key": "ShowDayOfWeek",
			"kind": "bool",
			"name": "Show the day of week in the menu bar clock",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.menuextra.clock",
			"key": "ShowDate",
			"kind": "int",
			"name": "Don't show the date in the menu bar clock",
			"tool": "macos_defaults",
			"value": 0
		},
		{
			"action": "set",
			"domain": "com.apple.menuextra.clock",
			"key": "ShowAMPM",
			"kind": "bool",
			"name": "Show AM/PM in the menu bar clock",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "QuitMenuItem",
			"kind": "bool",
			"name": "Allow quitting Finder via ⌘ + Q",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "DisableAllAnimations",
			"kind": "bool",
			"name": "Disable window and Get Info animations",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "ShowExternalHardDrivesOnDesktop",
			"kind": "bool",
			"name": "Hide icons for hard drives, servers, and removable media on the desktop",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "ShowHardDrivesOnDesktop",
			"kind": "bool",
			"name": "Hide icons for hard drives on the desktop",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "ShowRemovableMediaOnDesktop",
			"kind": "bool",
			"name": "Hide icons for removable media on the desktop",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "AppleShowAllFiles",
			"kind": "bool",
			"name": "Show hidden files by default",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "AppleShowAllExtensions",
			"kind": "bool",
			"name": "Show all filename extensions",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "ShowPathbar",
			"kind": "bool",
			"name": "Show path bar",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "_FXSortFoldersFirst",
			"kind": "bool",
			"name": "Keep folders on top when sorting by name",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "FXDefaultSearchScope",
			"kind": "string",
			"name": "When performing a search, search the current folder by default",
			"tool": "macos_defaults",
			"value": "SCcf"
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "FXEnableExtensionChangeWarning",
			"kind": "bool",
			"name": "Disable the warning when changing a file extension",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.springing.enabled",
			"kind": "bool",
			"name": "Enable spring loading for directories",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.springing.delay",
			"kind": "float",
			"name": "Remove the spring loading delay for directories",
			"tool": "macos_defaults",
			"value": 0
		},
		{
			"action": "set",
			"domain": "com.apple.desktopservices",
			"key": "DSDontWriteNetworkStores",
			"kind": "bool",
			"name": "Avoid creating .DS_Store files on network volumes",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.desktopservices",
			"key": "DSDontWriteUSBStores",
			"kind": "bool",
			"name": "Avoid creating .DS_Store files on USB volumes",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.frameworks.diskimages",
			"key": "skip-verify",
			"kind": "bool",
			"name": "Disable disk image verification",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.frameworks.diskimages",
			"key": "skip-verify-locked",
			"kind": "bool",
			"name": "Disable disk image verification for locked images",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.frameworks.diskimages",
			"key": "skip-verify-remote",
			"kind": "bool",
			"name": "Disable disk image verification for remote images",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.finder",
			"key": "FXPreferredViewStyle",
			"kind": "string",
			"name": "Use list view in all Finder windows by default",
			"tool": "macos_defaults",
			"value": "Nlsv"
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSDocumentSaveNewDocumentsToCloud",
			"kind": "bool",
			"name": "Save to disk by default, not iCloud",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.LaunchServices",
			"key": "LSQuarantine",
			"kind": "bool",
			"name": "Disable the \"Are you sure you want to open this application?\" dialog",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.systempreferences",
			"key": "NSQuitAlwaysKeepsWindows",
			"kind": "bool",
			"name": "Disable Resume system-wide",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSAutomaticCapitalizationEnabled",
			"kind": "bool",
			"name": "Disable automatic capitalization",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSAutomaticDashSubstitutionEnabled",
			"kind": "bool",
			"name": "Disable smart dashes",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSAutomaticPeriodSubstitutionEnabled",
			"kind": "bool",
			"name": "Disable automatic period substitution",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSAutomaticQuoteSubstitutionEnabled",
			"kind": "bool",
			"name": "Disable smart quotes",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "NSAutomaticSpellingCorrectionEnabled",
			"kind": "bool",
			"name": "Disable auto-correct",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "com.apple.driver.AppleBluetoothMultitouch.trackpad",
			"key": "TrackpadCornerSecondaryClick",
			"kind": "int",
			"name": "Enable tap to click for trackpad",
			"tool": "macos_defaults",
			"value": 2
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.trackpad.trackpadCornerClickBehavior",
			"kind": "int",
			"name": "Enable tap to click for trackpad (global)",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.trackpad.enableSecondaryClick",
			"kind": "bool",
			"name": "Enable secondary click for trackpad",
			"tool": "macos_defaults",
			"value": true
		},
		// Scroll direction is one of the few defaults nothing can apply live: the
		// window server reads it at login and there is no process to restart, so
		// a fresh machine keeps scrolling Apple's way until the next logout no
		// matter how many times rwr runs. Check it with
		// `defaults read -g com.apple.swipescrolldirection` - 0 is the value this
		// sets, and it means "natural" scrolling is off. If the value reads 0 and
		// scrolling still feels inverted, the setting is applied and pending a
		// logout; it is not drift.
		//
		// This one key covers trackpad and mouse both. macOS shows a separate
		// checkbox per device but writes them to the same global key.
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "com.apple.swipescrolldirection",
			"kind": "bool",
			"name": "Disable \"natural\" scrolling",
			"tool": "macos_defaults",
			"value": false
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "AppleKeyboardUIMode",
			"kind": "int",
			"name": "Enable full keyboard access for all controls",
			"tool": "macos_defaults",
			"value": 3
		},
		{
			"action": "set",
			"domain": "NSGlobalDomain",
			"key": "AppleFontSmoothing",
			"kind": "int",
			"name": "Enable subpixel font rendering on non-Apple LCDs",
			"tool": "macos_defaults",
			"value": 1
		},
		{
			"action": "set",
			"domain": "com.apple.ImageCapture",
			"key": "disableHotPlug",
			"kind": "bool",
			"name": "Prevent Photos from opening automatically when devices are plugged in",
			"tool": "macos_defaults",
			"value": true
		},
		{
			"action": "set",
			"domain": "com.apple.TimeMachine",
			"key": "DoNotOfferNewDisksForBackup",
			"kind": "bool",
			"name": "Prevent Time Machine from prompting to use new hard drives as backup volume",
			"tool": "macos_defaults",
			"value": true
		}
	]
}
