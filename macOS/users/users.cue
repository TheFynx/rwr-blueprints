// macOS counterpart to Arch/users/users.cue: fish as the login shell.
//
// Common/users/users.cue is deliberately not imported - it adds the `docker`
// group, which does not exist on macOS.
//
// brew's prefix is arch-dependent (Apple Silicon /opt/homebrew, Intel
// /usr/local), so the path is resolved at render time. The users processor sets
// the OpenDirectory UserShell attribute; scripts/shell.cue registers the same
// path in /etc/shells, which dscl does not touch.
{
	"users": [
		{
			"action": "modify",
			"name": "{{ .User.username }}",
			// Backquotes, not \" - the Go template action is parsed before CUE
			// sees the file, and \" is not valid template syntax.
			"new_shell": "{{ if eq .System.osArch `arm64` }}/opt/homebrew/bin/fish{{ else }}/usr/local/bin/fish{{ end }}"
		}
	]
}
