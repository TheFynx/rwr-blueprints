# Animation workstation

An explicitly selected workstation build for an existing **Omarchy x86-64**
installation with a **Turing-or-newer NVIDIA GPU**. It reuses Common's Linux
base, dotfiles, app configs, users, Git checkouts, and credential declarations,
plus Omarchy's desktop payload, plugins, shared Minecraft/Midgar themes, defaults, and hooks.
It does not install Omarchy itself.

This tree is intentionally outside the root manifest: adding another matching
Omarchy entry would make automatic selection ambiguous. Select its init file
directly; ordinary Omarchy runs continue to select the existing tree.

## Software

| Purpose | Packages |
|---|---|
| Production | Blender, OpenToonz, DaVinci Resolve (free), Unreal Engine (source build) |
| Media conversion and inspection | FFmpeg, MediaInfo, mpv (shared base) |
| Drawing and asset preparation | Krita, Inkscape, GIMP (shared base), ImageMagick |
| Audio cleanup, recording and mixing | Audacity, Ardour |
| Local character and story planning | Manuskript, bibisco Community Edition (`bibisco-ce`, AUR) |
| Image sequences and color | OpenImageIO tools, OpenColorIO, OpenEXR |
| GPU compute | CUDA, NVIDIA OpenCL, OpenCL ICD loader |
| GPU checks | NVIDIA Settings / nvidia-smi, clinfo, Vulkan tools |
| Asset storage and builds | Git LFS, Clang, LLD, Ninja, shared base-devel / CMake |

The production packages are unprofiled: no `--profile` is needed. This tree
imports the shared bases instead of the complete general Arch workstation list.
It does not import the Radeon stack, laptop tuning, or machine-specific data-drive
mounts. Project storage paths and color transforms remain project choices.

## Before provisioning

- Update the underlying Omarchy system first; Arch partial upgrades are unsupported.
- The driver declaration uses `nvidia-open-dkms` and `linux-headers` for the stock
  `linux` kernel. For LTS/Zen/custom kernels, replace/add matching kernel headers
  before applying. Older NVIDIA GPUs need a compatible legacy driver and CUDA
  stack; do not apply this driver declaration to them.
- DaVinci Resolve's AUR package requires a manually downloaded Linux installer
  ZIP from [Blackmagic support](https://www.blackmagicdesign.com/support/family/davinci-resolve-and-fusion).
  With yay available, run `yay -G davinci-resolve` inside `~/.cache/yay/`, inspect
  its PKGBUILD, and place the exact ZIP it expects in that package directory.
  If using a custom yay build directory, stage it there instead. Keep the
  vendor installer outside this Git repository.
- `unreal-engine` builds from source. Link your Epic and GitHub accounts and
  accept the repository invitation using [Epic's instructions](https://www.unrealengine.com/en-US/ue-on-github).
  Ensure the build user can access `EpicGames/UnrealEngine` with the authentication
  method expected by the current AUR PKGBUILD. RWR's SSH key enrollment alone
  does not grant Epic repository access. Review the PKGBUILD and its current
  storage/build requirements; leave substantial free space for source and build
  artifacts. The initial build is large and slow.

These are prerequisites to the AUR pass, not downloads that RWR can complete
without vendor interaction. Use `davinci-resolve-studio` instead of
`davinci-resolve` only when you own Studio and have its matching installer.

## Apply

From the repository root:

```bash
rwr validate Linux/Animation --blueprints
rwr run all --init-file ./Linux/Animation/init.cue --dry-run
rwr run all --init-file ./Linux/Animation/init.cue
```

For a fresh remote checkout, select the file explicitly:

```bash
rwr run all --init-file thefynx/rwr-blueprints/Linux/Animation/init.cue
```

Credentials stay excluded from full runs, following the existing Omarchy policy.
Restore the signing identity separately when ready:

```bash
rwr run credentials --init-file ./Linux/Animation/init.cue --profile bitwarden
```

## Application setup and checks

After a driver installation, reboot before checking GPU acceleration:

```bash
nvidia-smi
clinfo
vulkaninfo --summary
ffmpeg -encoders | rg nvenc
```

- In Blender, select CUDA or OptiX in Preferences → System → Cycles Render
  Devices, enable the GPU, and select GPU Compute for the scene. Installation
  does not change individual scenes' render settings.
- In OpenToonz, set the FFmpeg path to `/usr/bin` in Preferences → Import/Export
  and restart it, as described in the [OpenToonz documentation](https://github.com/opentoonz/opentoonz_docs/blob/master/source/using_ffmpeg_with_opentoonz.rst).
- In Resolve, confirm the NVIDIA GPU and CUDA processing mode in Preferences
  → Memory and GPU. Resolve's Linux codec availability depends on edition and
  version; FFmpeg provides a separate transcoding path for incompatible media.
- Git LFS is registered for the user by the setup script. Select tracking patterns
  per production repository; the blueprint does not rewrite existing asset history.

Validation checks blueprint structure and imports, not successful vendor builds,
GPU hardware compatibility, or live rendering. This tree was validated and its
package processor checked in dry-run mode; application installs have not been run.

Manuskript and bibisco Community Edition store projects locally and work offline.
No cloud account or hosted story service is configured by this build.

### bibisco Community Edition installer

The AUR `bibisco-ce` package is the local Community Edition. Its current recipe
expects a vendor ZIP supplied manually, rather than downloading it automatically.
Get the free Community Edition Linux x64 ZIP from https://bibisco.com and stage
`bibisco-linux-x64-4.0.1-CE.zip` in `${XDG_CACHE_HOME:-$HOME/.cache}/yay/bibisco-ce/`
before running the AUR package pass. The filename/version must match the recipe
if it updates. Do not substitute the `bibisco` package: that recipe expects the
paid Supporters Edition ZIP. Manuskript requires no vendor-installer staging.
