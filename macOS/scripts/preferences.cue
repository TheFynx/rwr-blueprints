// Whole-plist preferences that macos_defaults cannot express. Its tool runs
// `defaults write <domain> <key> -<kind> <value>` with a single scalar, but both
// domains here store nested dictionaries - one per keybinding - so they are
// imported wholesale from the staging copies files/files.cue delivers.
//
// A plist copied directly into ~/Library/Preferences does NOT work: cfprefsd
// caches the live contents and rewrites the file from memory, silently undoing
// the copy. `defaults import` goes through cfprefsd, which is why these are
// scripts rather than file targets.
{
	"scripts": [
		{
			"action": "run",
			"content": "#!/bin/bash\nset -euo pipefail\n\n# Rectangle keeps every binding in one plist as nested dicts, so `defaults\n# import` is the only way to apply it wholesale. Rectangle must not be running:\n# it rewrites its plist from memory on exit and would clobber the import.\nsrc=\"$HOME/.local/share/rwr/preferences/com.knollsoft.Rectangle.plist\"\nif [ ! -f \"$src\" ]; then\n\techo \"no staged Rectangle plist at $src; nothing to import\" >&2\n\texit 0\nfi\n\nwas_running=0\nif pgrep -qx Rectangle; then\n\twas_running=1\n\tosascript -e 'quit app \"Rectangle\"' || killall Rectangle || true\n\t# Give it a moment to finish writing its own plist before we overwrite.\n\tfor _ in 1 2 3 4 5; do\n\t\tpgrep -qx Rectangle || break\n\t\tsleep 1\n\tdone\nfi\n\ndefaults import com.knollsoft.Rectangle \"$src\"\n\nif [ \"$was_running\" -eq 1 ]; then\n\topen -a Rectangle || true\nfi\n",
			"exec": "bash",
			"name": "import_rectangle_prefs"
		},
		{
			"action": "run",
			"content": "#!/bin/bash\nset -euo pipefail\n\n# The system hotkey map (Mission Control, Spaces switching, screenshots, and the\n# Spotlight binding freed up for Alfred) lives in one plist of nested dicts, so\n# it cannot be a macos_defaults scalar write either.\nsrc=\"$HOME/.local/share/rwr/preferences/com.apple.symbolichotkeys.plist\"\nif [ ! -f \"$src\" ]; then\n\techo \"no staged symbolichotkeys plist at $src; nothing to import\" >&2\n\texit 0\nfi\n\ndefaults import com.apple.symbolichotkeys \"$src\"\n\n# cfprefsd holds the previous contents in memory; without this the import is\n# visible in `defaults read` but the window server keeps the old bindings.\nkillall cfprefsd || true\n\n# Re-register the hotkey map with the window server. Without this the new\n# bindings only take effect at next login.\n/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u || true\n",
			"exec": "bash",
			"name": "import_symbolic_hotkeys"
		}
	]
}
