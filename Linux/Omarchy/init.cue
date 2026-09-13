// Omarchy tree: the opinionated Arch + Hyprland distro gets its own tree
// because it owns most of ~/.config itself. This tree overlays only what is
// ours (keybinds, pinned nvim) and imports the shared Arch package bases.
// Matched by distro: omarchy (ID=omarchy, ID_LIKE=arch).
{
	"blueprints": {
		"format": "cue",
        except: ["credentials"],
		"git": {
			"target": "{{ .User.home }}/git/thefynx/rwr-blueprints",
			"url": "https://github.com/thefynx/rwr-blueprints.git"
		},
		"location": ".",
		"order": ["ssh_keys", "scripts", "packages", "users", "files", "services", "git"]
	},
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
