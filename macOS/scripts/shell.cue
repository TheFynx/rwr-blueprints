// /etc/shells is the allow-list chsh and some login paths consult. The users
// processor sets the OpenDirectory UserShell (see ../users/users.cue) but cannot
// edit /etc/shells, so a fish registered only there is a shell chsh refuses.
// Scripts run after packages in the default run order, so brew has installed
// fish by the time this executes.
//
// The brew prefixes are checked explicitly rather than trusting `command -v`:
// this runs elevated, and root's PATH does not necessarily carry /opt/homebrew/bin.
{
	"scripts": [
		{
			"action": "run",
			"content": "#!/bin/bash\nset -euo pipefail\nfish_path=\"\"\nfor candidate in /opt/homebrew/bin/fish /usr/local/bin/fish \"$(command -v fish || true)\"; do\n  if [ -n \"$candidate\" ] && [ -x \"$candidate\" ]; then\n    fish_path=\"$candidate\"\n    break\n  fi\ndone\nif [ -z \"$fish_path\" ]; then\n  echo \"fish not found; skipping /etc/shells registration\" >&2\n  exit 0\nfi\nif grep -qxF \"$fish_path\" /etc/shells; then\n  echo \"$fish_path already in /etc/shells\"\nelse\n  printf '%s\\n' \"$fish_path\" >> /etc/shells\n  echo \"added $fish_path to /etc/shells\"\nfi\n",
			"elevated": true,
			"name": "register_fish_in_etc_shells"
		}
	]
}
