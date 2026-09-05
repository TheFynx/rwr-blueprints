// The Dock is curated here rather than owned outright: rwr strips the tiles
// Apple seeds on a fresh install - Safari, Mail, Freeform, TV, Music, News, App
// Store, iPhone Mirroring and friends - and guarantees the tiles listed below
// exist, but it leaves anything else alone. Work apps dragged in by hand
// (Rippling, 1Password, Slack) survive every run; only Apple's defaults and
// nothing else are removed.
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
			"content": "#!/bin/bash\nset -euo pipefail\n\n# Tiles rwr guarantees are present, in this order. Anything already in the Dock\n# that is not in this list and not in the purge list below is left alone - work\n# apps like Rippling, 1Password and Slack are the user's to arrange, not rwr's.\napps=(\n\t\"/Applications/Brave Browser.app\"\n\t\"/Applications/Ghostty.app\"\n\t\"/Applications/Visual Studio Code.app\"\n\t\"/Applications/Claude.app\"\n\t\"/System/Applications/Apps.app\"\n\t\"/System/Applications/System Settings.app\"\n)\n\n# Apple's fresh-install Dock seed. These are removed whenever they appear, which\n# is what makes a new machine converge without hand-dragging tiles off.\npurge=(\n\t\"/System/Applications/App Store.app\"\n\t\"/System/Applications/Calendar.app\"\n\t\"/System/Applications/Contacts.app\"\n\t\"/System/Applications/FaceTime.app\"\n\t\"/System/Applications/Freeform.app\"\n\t\"/System/Applications/Journal.app\"\n\t\"/System/Applications/Mail.app\"\n\t\"/System/Applications/Maps.app\"\n\t\"/System/Applications/Messages.app\"\n\t\"/System/Applications/Music.app\"\n\t\"/System/Applications/News.app\"\n\t\"/System/Applications/Notes.app\"\n\t\"/System/Applications/Photos.app\"\n\t\"/System/Applications/Podcasts.app\"\n\t\"/System/Applications/Reminders.app\"\n\t\"/System/Applications/Safari.app\"\n\t\"/System/Applications/Shortcuts.app\"\n\t\"/System/Applications/Stocks.app\"\n\t\"/System/Applications/TV.app\"\n\t\"/System/Applications/iPhone Mirroring.app\"\n\t\"/System/Applications/Utilities/Screen Sharing.app\"\n\t\"/Applications/Safari.app\"\n)\n\n# _CFURLString is stored percent-encoded with a trailing slash. A space is the\n# only character these paths contain that needs encoding.\nurl_for() {\n\tlocal path=\"${1%/}/\"\n\tprintf 'file://%s' \"${path// /%20}\"\n}\n\nmapfile -t have < <(defaults read com.apple.dock persistent-apps 2>/dev/null |\n\tsed -n 's/^ *\"_CFURLString\" = \"\\(.*\\)\";$/\\1/p')\n\n# Build the purge set as encoded URLs so membership is a plain string compare.\ndeclare -A drop=()\nfor app in \"${purge[@]}\"; do\n\tdrop[\"$(url_for \"$app\")\"]=1\ndone\n\n# Keep the user's existing order for tiles that survive; managed tiles that are\n# missing get appended after them.\nwant=()\nfor url in \"${have[@]}\"; do\n\t[ -n \"${drop[$url]:-}\" ] && continue\n\twant+=(\"$url\")\ndone\n\nfor app in \"${apps[@]}\"; do\n\tif [ ! -d \"$app\" ]; then\n\t\techo \"skipping $app: not installed on this machine\" >&2\n\t\tcontinue\n\tfi\n\turl=\"$(url_for \"$app\")\"\n\tpresent=0\n\tfor existing in \"${want[@]}\"; do\n\t\t[ \"$existing\" = \"$url\" ] && { present=1; break; }\n\tdone\n\t[ \"$present\" -eq 0 ] && want+=(\"$url\")\ndone\n\nif [ \"${have[*]:-}\" = \"${want[*]:-}\" ]; then\n\techo \"Dock already holds the managed tiles with no Apple defaults left; leaving it alone\"\n\texit 0\nfi\n\n# -array with no values empties it; -array-add appends one tile dictionary in the\n# shape the Dock stores.\ndefaults write com.apple.dock persistent-apps -array\nfor url in \"${want[@]}\"; do\n\tdefaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${url}</string><key>_CFURLStringType</key><integer>15</integer></dict></dict><key>tile-type</key><string>file-tile</string></dict>\"\ndone\n\n# The Dock only reads persistent-apps at launch, and it rewrites its own plist\n# from memory when it exits, so the restart has to follow the writes.\nkillall Dock || true\n",
			"exec": "bash",
			"name": "curate_dock"
		}
	]
}
