// Shared user shaping (docker group) + fish login shell.
{
	"users": [
		{
			"import": "../../../Common/users/users.cue"
		},
		{
			"action": "modify",
			"name": "{{ .UserDefined.USERNAME }}",
			"new_shell": "/usr/bin/fish"
		}
	]
}
