// Shared Linux data-drive setup. It remains opt-in via the data-drives
// profile because its UUIDs identify one workstation; the scripts safely skip
// absent disks even when a run is not profile-filtered.

// Two scripts keep a home-link conflict from preventing the mount step.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "data-drives.sh",
			"profiles": ["data-drives"],
			"source": "./"
		},
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "home-links.sh",
			"profiles": ["data-drives"],
			"source": "./"
		}
	]
}
