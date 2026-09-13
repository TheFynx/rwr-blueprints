{
	"blueprints": {
		"format": "cue",
        except: ["credentials"],
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		// Exhaustive list of processors to run, in this order: rwr runs only
		// the processors named here and skips the rest silently. Scripts run
		// first so the rename-migration purges land before package installs.
		// Package files carry numeric prefixes (1-pacman.cue, 2-aur.cue) so
		// walk order keeps repo packages ahead of AUR builds.
		"order": ["scripts", "packages", "users", "files", "services", "git"]
	},
	"packageManagers": [
		{
			"action": "install",
			"name": "yay"
		}
	],
    // Credential configuration is explicit and rerunnable after machine setup.
    credentialPolicy: {setup: "explicit", onUnavailable: "skip"}
    credentialProviders: [{
        name: "personal-vault"
        provider: "bitwarden"
        server: "https://vault.bitwarden.com"
    }]
    credentials: [{
        name: "gpg_passphrase"
        description: "Passphrase for the personal signing key"
        scope: ["credentials"]
        sources: ["env:RWR_CRED_GPG_PASSPHRASE", "keyring"]
        references: [{connection: "personal-vault", item: "gpg-signing", field: "password"}]
    }]
    credentialAttachments: [
        {name: "signing-private-key", connection: "personal-vault", item: "gpg-signing", filename: "private.asc", write: true},
        {name: "signing-public-key", connection: "personal-vault", item: "gpg-signing", filename: "public.asc", write: true},
        {name: "signing-revocation", connection: "personal-vault", item: "gpg-signing", filename: "revocation.rev", write: true},
    ]
    variables: {userDefined: {gpg_fingerprint: "4B01A781536D3A8A05D65E63E5A290E73B0C6040"}}
}
