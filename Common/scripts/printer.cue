// CUPS printer setup. Opt-in via the printer profile because it names a
// specific printer (an office MFC reached over the LAN) and its address.
// The script skips cleanly when the printer is not reachable, so a machine
// without it is unaffected even when a run names no profiles.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "printer.sh",
			"profiles": ["printer"],
			"source": "./"
		}
	]
}
