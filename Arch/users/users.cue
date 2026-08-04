// One shared user definition for every Linux machine: Common/users/users.cue.
// Arch-specific: also set fish as the login shell.
{
	"users": [
		{
			"import": "../../Common/users/users.cue"
		},
		{
			"action": "modify",
			"name": "levi",
			"new_shell": "/usr/bin/fish"
		}
	]
}
