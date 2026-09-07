# RWR Blueprints

My personal system configuration blueprints for [RWR](https://github.com/fynxlabs/rwr).

## Structure

Everything is CUE. One `manifest.cue` at the root lists a configuration per
machine shape; `rwr` picks the right one from the detected OS/distro.

```bash
rwr-blueprints/
├── manifest.cue       # configuration per machine, matched on OS/distro
├── Common/            # shared across machines: git checkouts, users, Arch package bases
├── Arch/              # Arch-family workstation (PrismLinux Desktop; also matches pure Arch)
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
| `omarchy`    | Omarchy/Hyprland keybind overlay + sshd/ufw unlock         |
| `laptop`     | power management (tlp, powertop)                           |

`data-drives` hardcodes this machine's drive UUIDs — never enable it on a
different machine. It mounts the three data disks and symlinks
`Documents Downloads Pictures Videos adhoc backgrounds git` from
`/drives/home/levi/` into `$HOME`.

### Omarchy (Hyprland)

[Omarchy](https://github.com/omacom-io/omarchy) is DHH's Arch + Hyprland distro.
This repo deploys **one overlay file** onto it — `~/.config/hypr/bindings.lua`
— and nothing else, so Omarchy keeps owning its configs and stays upgrade-safe.
Install Omarchy first, then apply this blueprint with the `omarchy` profile.

Personal keybinds (identical across the COSMIC/Hyprland configs here):

| Keys                  | Action                                    |
|-----------------------|-------------------------------------------|
| `Ctrl+Alt+←/→`        | previous / next workspace                 |
| `Ctrl+Alt+Shift+←/→`  | move window to prev / next workspace      |
| `Ctrl+Shift+arrows`   | focus window in that direction            |
| `Super+arrows`        | move window in that direction             |
| `Super+Shift+arrows`  | swap window (Omarchy default, untouched)  |
| `Super+numpad 4/6/8/2`| focus monitor left / right / up / down    |

All forms verified live on Omarchy 4.0.2 / Hyprland 0.56.2; `KP_*` keysyms
bind natively (no `code:N` fallback needed). Omarchy defaults Super+arrows to
window *focus* — the overlay unbinds those first and relocates focus to
`Ctrl+Shift+arrows`.

Notes learned on real hardware/VM:

- **VirtualBox**: Omarchy needs the graphics controller set to **VBoxVGA**,
  **3D acceleration off**, and **128 MB VRAM**, or Hyprland black-screens after
  login (VMSVGA + 3D is the broken default). See omarchy discussion #176.
- **Firewall**: Omarchy ships ufw with default-deny incoming — even SSH. The
  `omarchy` profile opens 22 and enables sshd headlessly (equivalent of its
  Setup → Security → SSHD toggle).
- **Tray**: Omarchy's bar puts tray icons in a hover-to-reveal drawer by
  default and there is no "always expanded" setting. Per-item pinning is the
  supported fix: right-click the tray chevron → Manage → pin; it persists
  `pinned`/`hidden` arrays into the `omarchy.tray` entry of
  `~/.config/omarchy/shell.json`. Note that owning a `shell.json` freezes the
  bar layout (no merge with future Omarchy defaults; `omarchy bar defaults`
  restores).

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

### Future: rwr-native secrets

rwr's credential system (`credentials:` in the init file, sources
`env:`/`keyring`/`prompt`) has no Bitwarden source yet. Adding
`sources: [bw:item/field]` to rwr would let blueprints pull vault secrets —
this backup flow and the API tokens currently in `~/.extra` — at apply time.

## Features

- Dotfiles (`.bashrc`, `.gitconfig`, `.aliases`, etc.)
- Package lists for different distros
- SSH configs
- Git configuration with GPG signing
- Wallpaper collection
