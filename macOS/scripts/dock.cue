// The Dock is declarative here: rwr owns persistent-apps outright and rewrites
// it to exactly the tiles listed below, so anything Apple seeds on a fresh
// install - Safari, Freeform, TV, Music, News, App Store, iPhone Mirroring - is
// removed, and so is anything dragged in since the last run.
//
// This cannot be a macos_defaults configuration entry: that tool runs
// `defaults write <domain> <key> -<kind> <value>` with a single scalar value,
// and a Dock tile is an array of nested dictionaries.
//
// Finder and Trash are permanent tiles that live outside persistent-apps, so
// they survive this untouched. The Downloads stack lives in persistent-others,
// which this does not read or write.
{
	"scripts": [
		{
			"action": "run",
			"content": "#!/bin/bash\nset -euo pipefail\n\n# The tiles rwr owns. Finder and Trash are permanent tiles macOS keeps outside\n# persistent-apps, so they need no entry here; everything else Apple ships in\n# the default Dock is removed.\napps=(\n\t\"/System/Applications/Apps.app\"\n\t\"/System/Applications/System Settings.app\"\n)\n\n# _CFURLString is stored percent-encoded, with a trailing slash. A space is the\n# only character the paths above contain that needs encoding.\nurl_for() {\n\tlocal path=\"${1%/}/\"\n\tprintf 'file://%s' \"${path// /%20}\"\n}\n\nwant=\"\"\nfor app in \"${apps[@]}\"; do\n\tif [ ! -d \"$app\" ]; then\n\t\techo \"skipping $app: not installed on this machine\" >&2\n\t\tcontinue\n\tfi\n\twant=\"${want}$(url_for \"$app\")\"$'\\n'\ndone\n\nhave=$(defaults read com.apple.dock persistent-apps 2>/dev/null |\n\tsed -n 's/^ *\"_CFURLString\" = \"\\(.*\\)\";$/\\1/p')\n[ -n \"$have\" ] && have=\"${have}\"$'\\n'\n\nif [ \"$have\" = \"$want\" ]; then\n\techo \"Dock already holds exactly the tiles rwr manages; leaving it alone\"\n\texit 0\nfi\n\n# -array with no values empties it; -array-add appends one tile dictionary in\n# the shape the Dock stores. Rewriting wholesale is what makes this declarative:\n# anything dragged in since the last run is dropped again.\ndefaults write com.apple.dock persistent-apps -array\nfor app in \"${apps[@]}\"; do\n\t[ -d \"$app\" ] || continue\n\tdefaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$(url_for \"$app\")</string><key>_CFURLStringType</key><integer>15</integer></dict></dict><key>tile-type</key><string>file-tile</string></dict>\"\ndone\n\n# The Dock only reads persistent-apps at launch, and it rewrites its own plist\n# from memory when it exits, so the restart has to follow the writes.\nkillall Dock || true\n",
			"exec": "bash",
			"name": "curate_dock"
		}
	]
}
