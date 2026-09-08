// Data drives + home symlinks for the Desktop workstation. Gated behind the
// data-drives profile: the drive UUIDs are this machine's nvme hardware, so
// run with --profile desktop,radeon,data-drives here and leave it off any
// other Arch-family machine.
//
// Two scripts so a symlink conflict cannot stop the mount step: rwr aborts
// the rest of a scripts file on the first failure.
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
