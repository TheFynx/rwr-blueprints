// NOTE: rwr resolves template/copy sources against the IMPORTING tree's
// directory, not this file's. Every Linux tree sits at Linux/<flavor>/,
// so ../../../Common/... is correct for all of them - do not 'fix' to ./
// App configs shared by every Linux tree: ghostty, alacritty, the
// pinned-AstroNvim lazy-lock. Trees import this file from their
// "directories" section. The gpg-key-* scripts that used to live in
// .local/bin were replaced by the rwr-profile-invoked gpg-backup /
// gpg-restore scripts (Common/scripts/gpg + the gpg_passphrase
// credential) - the delete entries below clear stale copies from
// machines that got the old deploy.
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
	],
	"files": [
		{
			"action": "delete",
			"name": "gpg-key-backup",
			"target": "{{ .User.home }}/.local/bin/"
		},
		{
			"action": "delete",
			"name": "gpg-key-restore",
			"target": "{{ .User.home }}/.local/bin/"
		}
	]
}
