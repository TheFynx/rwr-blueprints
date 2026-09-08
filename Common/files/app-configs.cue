// NOTE: rwr resolves template/copy sources against the IMPORTING tree's
// directory, not this file's. Every Linux tree sits at Linux/<flavor>/,
// so ../../../Common/... is correct for all of them - do not 'fix' to ./
// App configs + user binaries shared by every Linux tree: ghostty, alacritty,
// the pinned-AstroNvim lazy-lock, and the gpg-key-backup/restore scripts.
// Trees import this file from their "directories" section.
{
	"directories": [
		{
			"action": "copy",
			"name": ".config",
			"source": "../../../Common/files/src/",
			"target": "{{ .User.home }}/"
		},
		{
			"action": "copy",
			"name": ".local",
			"source": "../../../Common/files/src/",
			"target": "{{ .User.home }}/"
		}
	]
}
