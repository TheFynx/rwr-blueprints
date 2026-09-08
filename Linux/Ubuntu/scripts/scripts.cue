// Vendor repos + packages (elevated), language tools (user), flatpak apps.
// Scripts live in Common/scripts/debian/ so both trees share them.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "vendor-repos.sh",
			"source": "../../../Common/scripts/debian/"
		},
		{
			"action": "run",
			"exec": "bash",
			"name": "dev-tools.sh",
			"source": "../../../Common/scripts/debian/"
		},
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "flatpak-apps.sh",
			"source": "../../../Common/scripts/debian/"
		}
	]
}
