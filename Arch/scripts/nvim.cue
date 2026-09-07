// Pinned AstroNvim checkout. The template repo tags nothing, so the pin is a
// commit SHA; plugins are pinned by Arch/files/src/.config/nvim/lazy-lock.json.
// To update: bump PINNED in nvim.sh, regen the lock from a sandboxed HOME,
// and copy the new lazy-lock.json over the committed one.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"name": "nvim.sh",
			"source": "./"
		}
	]
}
