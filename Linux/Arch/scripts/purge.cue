// Stale-default purge. Why a script and not a packages "remove" entry:
// pacman -R fails on absent targets, so the remove entries kept failing every
// run after the first convergence (node-lts-jod in particular never existed -
// the real package name is nodejs-lts-jod). This skips installed-ness quietly.
//
// nodejs is purged because bitwarden-cli requires nodejs-lts-jod and the two
// conflict; flip this and the pacman entry together if current node is ever
// wanted back over the Bitwarden CLI.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "purge-defaults.sh",
			"source": "./"
		}
	]
}
