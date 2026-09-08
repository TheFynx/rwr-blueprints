// Shared user shaping (docker group) + fish login shell.
{
	"users": [
		{
			"import": "../../../Common/users/users.cue"
		},
		{
			"action": "modify",
			"name": "levi",
			"new_shell": "/usr/bin/fish"
		}
	]
}
