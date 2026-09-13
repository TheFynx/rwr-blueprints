# Delayed credential setup

Requires the RWR credentials processor feature. Each Linux tree excludes managed vault access during `rwr run all` by default.

- Restore/configure the signing identity: `rwr run credentials --profile bitwarden`
- Provider installation/login only: `rwr run credentials --profile bitwarden-setup`
- Explicit backup: `rwr run credentials --profile gpg-backup`
- Machine setup with explicit exclusion: `rwr run all --except credentials`

GPG is invoked directly by RWR. No shell script or jq orchestrates credential work. The fingerprint comes from the init file's `variables.userDefined.gpg_fingerprint`; edit that trusted value when rotating keys. Ultimate ownertrust and Git commit signing are explicitly requested by the restore task, preserving the previous personal workflow.

The named Bitwarden connection uses a separate CLI data directory under the OS config directory's `rwr/credential-providers/`. Login/MFA and unlock happen during the explicit run. An unlocked session lives only for that RWR process; installation, imported keys, trust and Git configuration persist. Your existing Bitwarden CLI account is not logged out or reconfigured. No broad `bw_session` or passphrase exposure to scripts is needed.

Backups retain the old attachment until the replacement is downloaded and verified. The optional revocation certificate is included when present locally. No live restore or backup is performed by repository validation.
