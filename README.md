# RWR Blueprints

My personal system configuration blueprints for [RWR](https://github.com/fynxlabs/rwr).

## Structure

```bash
rwr-blueprints/
├── Arch/              # Arch Linux configs
├── Archcraft/         # Archcraft configs
├── Common/            # Shared dotfiles and packages
├── macOS/             # macOS configs
├── OpenMandriva/      # OpenMandriva configs
├── PopOS/             # Pop!_OS configs
└── Windows/           # Windows/WSL configs
```

## Usage

```bash
cd <system-directory>
rwr apply bootstrap.yaml
rwr apply files/dots.yaml
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
