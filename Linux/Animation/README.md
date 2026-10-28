# Animation workstation

An explicitly selected workstation build for an existing **Omarchy x86-64**
installation with a **Turing-or-newer NVIDIA GPU**. It reuses Common's Linux
base, dotfiles, app configs, users, Git checkouts, and credential declarations,
plus Omarchy's desktop payload, plugins, shared Minecraft/Midgar themes, defaults, and hooks.
It does not install Omarchy itself.

Choose **animation** in the root manifest's interactive configuration picker,
or select it explicitly:

```bash
rwr run all --init-file ./manifest.cue --config-name animation
```

Both Omarchy builds appear as matching options. The ordinary `omarchy` entry
is the default for headless runs without `--config-name`. Direct selection of
`./Linux/Animation/init.cue` also remains supported.

## Software

| Purpose | Packages |
|---|---|
| Production | Blender, OpenToonz, Unreal Engine (source build) |
| Media conversion and inspection | FFmpeg, MediaInfo, mpv (shared base) |
| Drawing and asset preparation | Krita, Inkscape, GIMP (shared base), ImageMagick |
| Audio cleanup, recording and mixing | Audacity, Ardour |
| Local character and story planning | Manuskript |
| Image sequences and color | OpenImageIO tools, OpenColorIO, OpenEXR |
| GPU compute | CUDA, NVIDIA OpenCL, OpenCL ICD loader |
| GPU checks | NVIDIA Settings / nvidia-smi, clinfo, Vulkan tools |
| Asset storage and builds | Git LFS, Clang, LLD, Ninja, shared base-devel / CMake |

Two applications are documented but **not** provisioned: DaVinci Resolve
(free) and bibisco Community Edition. Their AUR recipes expect a vendor
installer ZIP staged by hand, which halts an unattended run; see
[Manual installs](#manual-installs) for the how-to.

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
- `unreal-engine` builds from source. Link your Epic and GitHub accounts and
  accept the repository invitation using [Epic's instructions](https://www.unrealengine.com/en-US/ue-on-github).
  Ensure the build user can access `EpicGames/UnrealEngine` with the authentication
  method expected by the current AUR PKGBUILD. RWR's SSH key enrollment alone
  does not grant Epic repository access. Review the PKGBUILD and its current
  storage/build requirements; leave substantial free space for source and build
  artifacts. The initial build is large and slow.

Unreal Engine access is the only vendor prerequisite to the AUR pass.
DaVinci Resolve and bibisco CE are installed manually after provisioning;
see [Manual installs](#manual-installs).

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
- In Resolve, if you installed it manually, confirm the NVIDIA GPU and CUDA
  processing mode in Preferences → Memory and GPU. Resolve's Linux codec
  availability depends on edition and version; FFmpeg provides a separate
  transcoding path for incompatible media.
- Git LFS is registered for the user by the setup script. Select tracking patterns
  per production repository; the blueprint does not rewrite existing asset history.

Validation checks blueprint structure and imports, not successful vendor builds,
GPU hardware compatibility, or live rendering. This tree was validated and its
package processor checked in dry-run mode; application installs have not been run.

Manuskript stores projects locally and works offline. No cloud account or
hosted story service is configured by this build.

## Manual installs

Install these after the blueprint completes. Both recipes download nothing:
the AUR build expects a vendor installer ZIP you stage by hand, and keeping
that decision outside RWR is what lets the blueprint run unattended.

### DaVinci Resolve (free)

1. Download the Linux installer ZIP from the
   [Blackmagic support page](https://www.blackmagicdesign.com/support/family/davinci-resolve-and-fusion).
2. With yay available, fetch the recipe: `cd ~/.cache/yay && yay -G davinci-resolve`.
3. Inspect the generated PKGBUILD and place the exact ZIP it expects in that
   package directory. If you use a custom yay build directory, stage the ZIP
   there instead. Keep the vendor installer outside this Git repository.
4. Build and install: `yay -S davinci-resolve`. Use `davinci-resolve-studio`
   with its matching installer only when you own Studio.
5. On first launch, confirm the NVIDIA GPU and CUDA processing mode in
   Preferences → Memory and GPU (see the checks above).

### bibisco Community Edition

1. Download the free Community Edition Linux x64 ZIP from https://bibisco.com.
   The filename/version must match the recipe if it updates, currently
   `bibisco-linux-x64-4.0.1-CE.zip`.
2. `cd ~/.cache/yay && yay -G bibisco-ce`, inspect the PKGBUILD, and stage the
   ZIP in `${XDG_CACHE_HOME:-$HOME/.cache}/yay/bibisco-ce/`.
3. Build and install: `yay -S bibisco-ce`. Do not substitute the `bibisco`
   package: that recipe expects the paid Supporters Edition ZIP.

Manuskript, in contrast, requires no vendor-installer staging and is installed
by the blueprint's AUR pass.
