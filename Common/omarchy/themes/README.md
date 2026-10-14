# Shared Omarchy themes

Imported by both `Linux/Omarchy` and `Linux/Animation`. This is the common
Omarchy appearance layer; general OS dotfiles remain in `Common/files`.

- `src/home/.config/omarchy/themes/`: Midgar Mako and the Deepstone, Nether,
  and End Minecraft palettes, shell styles, Hyprland geometry, GTK/Qt styles,
  SVG assets, and the corrected centered Creeper screensaver.
- `src/minecraft/backgrounds/`: four reviewed 3840×2160 Real-ESRGAN x4plus
  exports stored once, copied into each Minecraft theme on deployment.
- `src/minecraft/original-backgrounds/`: original 1672×941 generations, retained
  once for provenance; not deployed. Prompts are in Deepstone's theme directory.
- `src/home/.config/omarchy/minecraft-integration/`: shared theme-switch logic,
  compatibility entry point (the implementation now lives in `theme-integration/`).
- `src/home/.config/omarchy/theme-integration/`: one runtime and declarative
  profiles for both Minecraft and Midgar.
- `src/home/.config/omarchy/lock-designs/`: Minecraft inventory and Midgar materia layouts,
  using Lock Screen Explorer's existing password/fingerprint authentication.
- `src/home/.local/share/`: theme icons and the
  Press Start 2P display font with its SIL Open Font License.
- `src/levi.menu/`: the existing user-owned menu clone with Minecraft’s grass
  block and the approved v3 FF7 meteor. Its native application-library fallback
  keeps Apps populated even when the host service facade is unavailable. It retains its ID so this laptop does not get a duplicate menu.
- `src/hooks/`: theme-set and post-boot integration; OmaSettings rendering.

`files.cue` deploys assets; `packages.cue` supplies Python, Qt configurators/SVG
support and Omarchy's Yaru fallback icons; `configuration.cue` installs the menu
and hooks and selects Deepstone. Desktop plugins/default applications stay in
`Linux/Omarchy/configuration/omarchy.cue`, which Animation already imports.
The lock-design setting belongs to the shared hook, so RWR does not overwrite
it with a competing desktop setting.

The ordinary file processor resolves imported sources against its consuming
blueprint directory. Both builds' `files/` directories have the same depth;
`files.cue` deliberately uses `../../../Common/omarchy/themes/src`. Configuration
sources instead resolve against their declaring file, so they use `src/`.
Keep this distinction when adding another consumer at a different depth.

## Deploy and select

From the repository root, inspect first:

```bash
rwr validate Linux/Omarchy
rwr run files --init-file ./Linux/Omarchy/init.cue --dry-run
rwr run configuration --init-file ./Linux/Omarchy/init.cue --dry-run
```

When replacing assets for a theme that is already active, run
`omarchy theme set <slug>` afterward to rebuild Omarchy’s current-theme staging
and run its hooks; RWR skips activation when the selected name is unchanged.

The normal build run installs dependencies, copies themes, installs hooks and
selects Deepstone after the desktop plugins are ready. Use `Linux/Animation`
in those commands for the animation build. Configuration alone expects the
files and packages to have been deployed already.

```bash
omarchy theme set minecraft-deepstone
omarchy theme set minecraft-nether
omarchy theme set minecraft-end
omarchy theme set midgar-mako
```

All Minecraft variants share four wallpapers. The background picker or
`omarchy theme bg next` changes scenes. Reopen existing GTK/Qt applications
when needed to load styling. Body/editor fonts remain unchanged.

The hook saves previous GTK/Qt/XSettings files, branding and lock
layout under `~/.local/state/omarchy/theme-integration/`; switching out
restores them. Runtime backups and machine state are never part of the payload.


Native asset builders now live once in the independent CLI project at
`~/git/thefynx/cli` and are installed with `fynx`. Use `fynx theme build minecraft`
or `fynx theme build midgar`; these are development commands, not provisioning
steps. The shared CLI build is imported from `Common/tools/fynx.cue` by both
builds. Until a remote repo exists, the CLI checkout must already be at that path.
Dependencies install before scripts so Go is ready for compilation.

Midgar's 14 backgrounds are now Real-ESRGAN x4plus upscales: 3840×2160 for the
original landscape, 3840×2402 for the thirteen 16:10 scenes. Their originals are
stored once in `src/midgar/original-backgrounds` and are not deployed. Midgar
includes a meteor menu logo, materia lock layout, icon themes and GTK/Qt
controls. Both families share restoration logic; the stock FF7 screensaver is
retained. The licensed Minecraft display font remains stored once.

Cursor appearance is left to the normal desktop settings. Theme hooks and
asset builders do not install or select custom cursors.
