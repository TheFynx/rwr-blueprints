// Pinned AstroNvim, shared script from Common/scripts/nvim.sh. The template
// repo tags nothing, so the pin is a commit SHA; plugins are pinned by the
// lazy-lock.json deployed with the app configs. To update: bump PINNED in
// Common/scripts/nvim.sh, regen the lock from a sandboxed HOME, commit both.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"name": "nvim.sh",
			"source": "../../../Common/scripts/"
		}
	]
}
