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
The Omarchy tree uses RWR's configuration processor for targeted desktop state:
plugins and their settings, shell idle timers, the active theme, default apps,
and a theme hook. Ordinary file blueprints keep the user-owned Hyprland bindings,
workspace and corner-placement helpers, menu extension, and Topgrade config.
Machine-specific monitor settings remain outside this tree.

The overlay has no profile gate: selecting Omarchy already chooses it, so
`--profile desktop,laptop,nvidia` also installs the repaired keybindings.

| Keys | Action |
|------|--------|
| `Ctrl+Alt+Left/Right` | Cycle through the Workspace Switcher range |
| `Ctrl+Alt+Up/Down` | Open Exposé / Workspace Switcher |
| `Ctrl+Alt+Shift+Left/Right` | Move window to adjacent workspace and follow |
| `Super+Ctrl+arrows` | Directional tile swap |
| `Super+Ctrl+numpad 4/6/8/2` | Directional tile swap, either Num Lock state |
| `Super+Ctrl+numpad 7/9/1/3` | Tile window in a corner, either Num Lock state |

`files/src/midgar-mako` contains the complete theme and all 14 wallpapers.
The Omarchy configuration installs and activates it, installs its branding hook,
and selects Brave, Ghostty, and VS Code as the default browser, terminal, and
editor. It installs and configures Exposé, Workspace Switcher, and Lock Screen
Explorer while retaining Omarchy's stock workspace and idle plugins. Idle uses
a 300-second screensaver timer and a 360-second lock timer; no custom idle clone
or complete `shell.json` copy is maintained.

The `ssh_keys` processor runs first on every provisioning pass, creates
`~/.ssh/git` if missing, and uploads its public key through RWR's GitHub
authentication prompt. An existing private key is reused; an old bootstrap
marker cannot skip GitHub enrollment.
No SSH key or secret is stored in this repository.

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

Credential setup runs through RWR's native credentials processor. These
blueprints require that feature and exclude credentials from ordinary
`rwr run all` runs, so machine setup can finish before vault login.

```bash
rwr run all --except credentials
rwr run credentials --profile bitwarden        # restore/configure signing identity
rwr run credentials --profile bitwarden-setup  # optional provider-only setup
rwr run credentials --profile gpg-backup       # explicitly selected backup
```

The trusted `personal-vault` connection uses Bitwarden. Create a Login item
named `gpg-signing` with the signing key's passphrase in its password field.
Restore expects its `private.asc` attachment; backup exports the existing
local key and uploads the declared private/public attachments, plus a
revocation certificate when present. RWR verifies each replacement by
downloading it before deleting the previous attachment.

The shared [native tasks](Common/credentials/gpg.cue) replace the old GPG
shell scripts. RWR handles installation, login/MFA, and unlock when explicitly
requested. Sessions remain private to the run; no `BW_SESSION` export or
passphrase exposure to scripts is required. An existing local signing key
avoids vault access during restore. Ownertrust and Git signing are explicit
settings in the restore task.

The expected fingerprint is
`4B01A781536D3A8A05D65E63E5A290E73B0C6040`. The provider, attachment
bindings, passphrase declaration, fingerprint, and native tasks are kept
together in the shared credential blueprint. Update that file when rotating
keys.

See [credential setup details](Common/credentials/README.md). Existing vault
items are retained; migration does not delete vault data or imported keys.

### nvim / AstroNvim

AstroNvim is pinned, not rolling: `Arch/scripts/nvim.sh` checks
`~/.config/nvim` out at a fixed template commit, and
`Arch/files/src/.config/nvim/lazy-lock.json` pins every plugin. To update:
bump `PINNED` in `nvim.sh`, regenerate the lock from a sandboxed
`HOME`/`XDG_*` tree (headless `nvim +Lazy! sync +qa`), and commit both.

## Features

- Dotfiles (`.bashrc`, `.gitconfig`, `.aliases`, etc.)
- Package lists for different distros
- SSH configs
- Git configuration with GPG signing
- Wallpaper collection
