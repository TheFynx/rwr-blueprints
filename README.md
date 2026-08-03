# RWR Blueprints

My personal system configuration blueprints for [RWR](https://github.com/fynxlabs/rwr).

## Structure

Everything is CUE. One `manifest.cue` at the root lists a configuration per
machine shape; `rwr` picks the right one from the detected OS/distro.

```bash
rwr-blueprints/
├── manifest.cue       # configuration per machine, matched on OS/distro
├── Common/            # shared across machines: git checkouts, users, Arch package bases
├── Arch/              # Arch workstation
├── Archcraft/         # Archcraft laptop
├── macOS/             # macOS
├── OpenMandriva/      # OpenMandriva
├── PopOS/             # Pop!_OS
└── Windows/           # Windows
```

Shared things live once in `Common/` and are pulled in per machine with
`import` entries. Payload files (dotfiles, app configs) sit under each
tree's `files/src/` and are not blueprints.

## Usage

```bash
# On any machine: point rwr at the repo, the manifest picks the tree.
rwr all --init-file https://github.com/TheFynx/rwr-blueprints

# Force a specific configuration:
rwr all --init-file https://github.com/TheFynx/rwr-blueprints --config-name archcraft

# Check a tree without applying:
rwr validate --blueprints Arch
```

## GPG Key Setup

After system rebuild, import GPG keys from Keybase:

```bash
# List keys in Keybase
keybase pgp export

# Import public key (replace $KEY with your key ID)
keybase pgp export -q $KEY | gpg --import

# Import secret key
keybase pgp export -q $KEY --secret | gpg --allow-secret-key-import --import

# Verify import
gpg --list-secret-keys --keyid-format LONG

# Configure git (use the sec key from the list above)
git config --global user.signingkey $KEY
git config --global commit.gpgsign true
```

## Features

- Dotfiles (`.bashrc`, `.gitconfig`, `.aliases`, etc.)
- Package lists for different distros
- SSH configs
- Git configuration with GPG signing
- Wallpaper collection
