// Laptop (Framework) sleep fixes and their shell.json convergence, opt-in via
// the laptop profile. Two entries because they run at different privilege
// levels: the idle/lock timings are the invoking user's shell.json (matching
// the values declared in configuration/omarchy.cue, so an already-used machine
// converges without hand edits), and the logind drop-in is system-level. The
// logind entry never restarts systemd-logind on a live graphical session —
// restarting logind tears the seat down and the desktop dies with it — so its
// file lands for the next boot instead.
{
	"scripts": [
		{
			"action": "run"
			"exec": "bash"
			"name": "laptop-idle.sh"
			"profiles": ["laptop"]
			"source": "./"
		},
		{
			"action": "run"
			"exec": "bash"
			"elevated": true
			"name": "laptop-logind.sh"
			"profiles": ["laptop"]
			"source": "./"
		}
	]
}
