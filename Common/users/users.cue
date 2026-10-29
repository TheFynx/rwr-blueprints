// Shared user shaping, every Linux machine. USERNAME defaults to levi in
// each tree's init.cue; override per machine with RWR_USERNAME=bob.
{
	"users": [
		{
			"action": "modify",
			"add_groups": ["docker"],
			"name": "{{ .UserDefined.USERNAME }}"
		}
	]
}
