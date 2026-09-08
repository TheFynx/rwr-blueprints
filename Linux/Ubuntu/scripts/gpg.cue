// Bitwarden-backed GPG key sync, invoked deliberately through rwr. The
// passphrase is resolved at run time through the bw:gpg-signing/password
// credential (see init.cue) with keyring/prompt fallback; scripts live in
// Common/scripts/gpg/. Profiles are what makes this opt-in - naming no
// profile runs everything, which is why both scripts are written to be
// safe under the permissive default (they explain and exit 0 when there is
// nothing to do on this machine).
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"name": "gpg-backup.sh",
			"profiles": ["gpg-backup"],
			"source": "../../../Common/scripts/gpg/"
		},
		{
			"action": "run",
			"exec": "bash",
			"name": "gpg-restore.sh",
			"profiles": ["gpg-restore"],
			"source": "../../../Common/scripts/gpg/"
		}
	]
}
