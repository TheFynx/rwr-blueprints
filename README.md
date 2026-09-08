# RWR Blueprints

My personal system configuration blueprints for [RWR](https://github.com/fynxlabs/rwr).

## Structure

Everything is CUE. One `manifest.cue` at the root lists a configuration per
machine shape; `rwr` picks the right one from the detected OS/distro.

```bash
rwr-blueprints/
├── manifest.cue           # one configuration per distro/OS, matched on detection
├── Common/                # shared everywhere: dotfiles, fish, ssh, git, users,
│   │                      # per-family package bases (packages/arch, packages/debian),
│   │                      # shared files (files/dot-config, dot-local) + scripts
├── Linux/
│   ├── Arch/              # general Arch family (PrismLinux Desktop matches here)
│   ├── Omarchy/           # opinionated distro: thin overlay, imports Arch bases
│   ├── Debian/            # apt: Common/packages/debian + vendor repos + cargo/go/npm/pipx
│   ├── Ubuntu/            # same tree shape as Debian, distro: ubuntu
│   ├── PopOS/             # Pop!_OS
│   └── OpenMandriva/      # OpenMandriva
├── macOS/                 # macOS
└── Windows/               # Windows
```

Shared things live once in `Common/` and are pulled in per machine with
`import` entries. Payload files (dotfiles, app configs) sit under each
tree's `files/src/` and are not blueprints.

## Usage

```bash
# On any machine: point rwr at the repo, the manifest picks the tree.
rwr all --init-file https://github.com/TheFynx/rwr-blueprints

# Check a tree without applying:
rwr validate --blueprints Arch
```

### Profiles (Arch workstation)

Profiles gate machine-specific bits. **rwr applies every profile-gated entry
when no `--profile` is given** — the filter only narrows when you name at
least one profile, so pass the full set you want on each run:

```bash
# Desktop workstation (PrismLinux "Desktop"):
rwr all --profile desktop,radeon,data-drives --init-file <repo>

# Another profile values: nvidia (vendor GPU stack), cosmic (deploy the COSMIC
# desktop tuning), laptop (tlp/powertop).
```

| Profile      | What it gates                                              |
|--------------|------------------------------------------------------------|
| `desktop`    | workstation packages (graphics base, desktop apps)         |
| `radeon`     | AMD GPU stack: vulkan-radeon, radeontop, ollama-rocm       |
| `nvidia`     | NVIDIA GPU stack: nvidia-dkms, nvidia-utils                |
| `data-drives`| /drives/{home,games,storage} fstab mounts + home symlinks  |
| `cosmic`     | COSMIC desktop config deployment (Cinnamon machine: skip)  |
| `laptop`     | power management (tlp, powertop)                           |

`data-drives` hardcodes this machine's drive UUIDs — never enable it on a
different machine. It mounts the three data disks and symlinks
`Documents Downloads Pictures Videos adhoc backgrounds git` from
`/drives/home/levi/` into `$HOME`.

### Omarchy (Hyprland)

[Omarchy](https://github.com/omacom-io/omarchy) is DHH's Arch + Hyprland distro.
The Omarchy tree captures the working user configuration from this machine:
`bindings.lua`, its `corner-placement.lua` helper, and the shell/menu/idle-plugin
integration for the Midgar Mako screensaver. It does not replace the main
Hyprland configuration or machine-specific monitor settings.

The overlay has no profile gate: selecting Omarchy already chooses it, so
`--profile desktop,laptop,nvidia` also installs the repaired keybindings.

| Keys | Action |
|------|--------|
| `Ctrl+Alt+Left/Right` | Previous/next numbered workspace |
| `Ctrl+Alt+Shift+Left/Right` | Move window to adjacent workspace and follow |
| `Super+Ctrl+arrows` | Directional tile swap |
| `Super+Ctrl+numpad 4/6/8/2` | Directional tile swap, either Num Lock state |
| `Super+Ctrl+numpad 7/9/1/3` | Tile window in a corner, either Num Lock state |

`files/src/midgar-mako` contains the complete theme and all 14 wallpapers.
The theme script installs and activates it with its screensaver launcher and
branding hook. Bootstrap installs the required tools before that script runs.
The captured shell configuration enables the included `levi.idle` plugin and
uses the same 150-second screensaver and 300-second lock timers.

The `ssh_keys` processor runs first on every provisioning pass, creates
`~/.ssh/git` if missing, and uploads its public key through RWR's GitHub
authentication prompt. An existing private key is reused; an old bootstrap
marker cannot skip GitHub enrollment.
No SSH key or secret is stored in this repository. These blueprints require the
RWR changes in FynxLabs/rwr#298 for bootstrap-before-vault setup and session export.

Notes learned on real hardware/VM:

- **VirtualBox**: Omarchy needs the graphics controller set to **VBoxVGA**,
  **3D acceleration off**, and **128 MB VRAM**, or Hyprland black-screens after
  login (VMSVGA + 3D is the broken default).
- **Tray**: Omarchy's bar puts tray icons in a hover-to-reveal drawer by
  default. Per-item pinning is the supported fix: right-click the tray
  chevron → Manage → pin.

### nvim / AstroNvim

AstroNvim is pinned, not rolling: `Arch/scripts/nvim.sh` checks
`~/.config/nvim` out at a fixed template commit, and
`Arch/files/src/.config/nvim/lazy-lock.json` pins every plugin. To update:
bump `PINNED` in `nvim.sh`, regenerate the lock from a sandboxed
`HOME`/`XDG_*` tree (headless `nvim +Lazy! sync +qa`), and commit both.

## GPG Key Setup

Keybase is out of the blueprints (it will eventually go offline); key custody
is [Bitwarden](https://bitwarden.com), wired into rwr natively: the trees
declare a `gpg_passphrase` credential with a `bw:gpg-signing/password` source,
and the hardened scripts in `Common/scripts/gpg/` run through rwr profiles.

One-time setup:

1. `bw login` (once, with 2FA). Before a run, `bw unlock` and export
   `BW_SESSION` in that shell — or answer rwr's prompt and let it save the
   value to the OS keyring.
2. In the vault, create a **Login item named `gpg-signing`** and put the key's
   passphrase in its **password** field (a Secure Note has no password field,
   so the `bw:` source could never read from it).
3. Run the backup:

```bash
rwr all --profile gpg-backup        # exports + uploads, round-trip verified
```

The scripts upload `public.asc`, `private.asc`, and the revocation cert as
attachments of the `gpg-signing` item, **replacing previous copies** (one
current backup, not a pile of dated ones). The private-key export keeps its
passphrase protection, the exposed passphrase is proven to unlock the key
*before* anything uploads, and the vault copy is downloaded back and
byte-compared before success is reported.

Restore on a fresh machine (after this blueprint applied):

```bash
rwr all --profile gpg-restore       # downloads, verifies fingerprint + passphrase, imports
```

Restore is a no-op on machines that already hold the key, so leaving both
profiles in a run is safe. Overrides when needed: `GPG_FINGERPRINT=...` and
`BW_GPG_ITEM=...` environment variables. Note: attachment **upload** needs a
paid Bitwarden plan (Premium or org); the `bw:` passphrase source does not.

> Migration: the earlier `~/.local/bin/gpg-key-*` scripts and their vault
> items ("GPG Key Backup", "GPG Backup Passphrase") are superseded — the next
> apply deletes the local copies; delete the two old vault items whenever the
> `gpg-signing` item has its first successful backup.

Git signing uses the key with fingerprint `4B01A781536D3A8A05D65E63E5A290E73B0C6040`,
set in `.gitconfig` by the blueprint. If the old `8BF6E007…` fingerprint
appears anywhere, it is dead — that key existed only in Keybase.

### nvim / AstroNvim

AstroNvim is pinned, not rolling: `Arch/scripts/nvim.sh` checks
`~/.config/nvim` out at a fixed template commit, and
`Arch/files/src/.config/nvim/lazy-lock.json` pins every plugin. To update:
bump `PINNED` in `nvim.sh`, regenerate the lock from a sandboxed
`HOME`/`XDG_*` tree (headless `nvim +Lazy! sync +qa`), and commit both.

## GPG Key Setup

Keybase is out of the blueprints (it will eventually go offline); the vault is
[Bitwarden](https://bitwarden.com) via its CLI. `rwr` deploys
`~/.local/bin/gpg-key-backup` and `~/.local/bin/gpg-key-restore` — key custody
runs on demand, never during apply.

One-time setup:

```bash
bw login                      # once, with 2FA
gpg-key-backup                # creates both vault items, exports + uploads
```

That produces two secure notes: **GPG Key Backup** (a dated, AES-256-encrypted
tarball attachment containing secret keys, public keys, ownertrust, and
revocation certs) and **GPG Backup Passphrase** (the passphrase for that
tarball — generated for you on first run). Every backup is downloaded back and
checksum-verified before the script reports success.

Restore on a fresh machine (after `rwr` applied this blueprint):

```bash
gpg-key-restore               # newest backup; or name a specific attachment
```

> The attachment is encrypted, but its passphrase lives in the same vault —
> keep one offline copy (USB) of the encrypted tarball so the two halves are
> never only together.

Git signing uses the key with fingerprint `4B01A781536D3A8A05D65E63E5A290E73B0C6040`,
set in `.gitconfig` by the blueprint. If the old `8BF6E007…` fingerprint
appears anywhere, it is dead — that key existed only in Keybase.

### rwr-native secrets

rwr ships a `bw:<item>[/<key>]` credential source (rwr 0.6.2+): init files
declare credentials whose value comes from the Bitwarden vault through the
`bw` CLI, falling back to the OS keyring, then a prompt — logs redact the
value, and a locked vault is a fall-through, not a crash. This repo uses it
for the GPG key passphrase (`gpg_passphrase`, above). The API tokens in
`~/.extra` are candidates for the same treatment: declare them as
`credentials` with `bw:<item>/field:<name>` sources and replace the raw
exports with `RWR_CRED_<NAME>` references.

## Features

- Dotfiles (`.bashrc`, `.gitconfig`, `.aliases`, etc.)
- Package lists for different distros
- SSH configs
- Git configuration with GPG signing
- Wallpaper collection
