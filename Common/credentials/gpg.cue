// Native RWR credential tasks. Ordinary machine setup excludes credentials.
// Restore: rwr run credentials --profile bitwarden
// Backup:  rwr run credentials --profile gpg-backup
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
credential_setup: [
    {
        name: "restore-signing-identity"
        profiles: ["bitwarden", "gpg-restore"]
        connection: "personal-vault"
        install: "if-missing"
        session: "ensure-ready"
        tasks: [{
            name: "personal-signing-key"
            kind: "gpg-restore"
            source: "signing-private-key"
            fingerprint: "4B01A781536D3A8A05D65E63E5A290E73B0C6040"
            passphrase: "gpg_passphrase"
            ownerTrust: 6
            configureGitSigning: true
        }]
    },
    {
        name: "backup-signing-identity"
        profiles: ["gpg-backup"]
        connection: "personal-vault"
        install: "if-missing"
        session: "ensure-ready"
        tasks: [{
            name: "personal-signing-key"
            kind: "gpg-backup"
            writeProfile: "gpg-backup"
            source: "signing-private-key"
            publicSource: "signing-public-key"
            revocationSource: "signing-revocation"
            fingerprint: "4B01A781536D3A8A05D65E63E5A290E73B0C6040"
            passphrase: "gpg_passphrase"
        }]
    },
    {
        name: "bitwarden-only"
        profiles: ["bitwarden-setup"]
        connection: "personal-vault"
        install: "if-missing"
        session: "ensure-ready"
    },
]
