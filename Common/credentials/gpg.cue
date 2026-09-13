// Native RWR credential tasks. Ordinary machine setup excludes credentials.
// Restore: rwr run credentials --profile bitwarden
// Backup:  rwr run credentials --profile gpg-backup
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
            fingerprint: "{{ .UserDefined.gpg_fingerprint }}"
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
            fingerprint: "{{ .UserDefined.gpg_fingerprint }}"
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
