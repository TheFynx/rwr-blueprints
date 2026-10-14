# Minecraft theme family

Three additional user-owned Omarchy themes:

- `minecraft-deepstone`: deepslate, grass green, diamond cyan, torchlight.
- `minecraft-nether`: blackstone, ember copper, crimson, muted gold.
- `minecraft-end`: obsidian, amethyst, pale End-stone, spectral cyan.

Switch using `omarchy theme set minecraft-deepstone` (or either other slug).
Use `omarchy theme bg next` or the Omarchy background picker to browse scenes.
Return to your previous theme with `omarchy theme set midgar-mako`.

The palette feeds Omarchy's current built-in templates for Ghostty, Alacritty,
Foot, Kitty, Neovim, VS Code, Helix, btop, Chromium/Brave, Obsidian, terminal
selectors, keyboard RGB, and supported coding assistants. Each theme also
supplies detailed shell colors, solid deepslate panels, ore-tinted control
states, square window/panel geometry, subtle shadows, and matching Yaru icons.
Existing plugin layouts, input settings, fonts, and monitor setup are retained.
Installed applications receive the integrations supported by Omarchy; application
restarts may be needed to display their new colors.

Four custom built-in ImageGen scenes are included: Overworld Sanctuary,
Deepstone Cavern, Nether Forge, and End Observatory. Original generation resolution was
1672×941. All installed backgrounds are now verified 3840×2160 Real-ESRGAN
x4plus upscales, not native 4K generations. Original images are preserved once in the blueprint shared
`src/minecraft/original-backgrounds/` directory. Prompt provenance is stored in
`minecraft-deepstone/WALLPAPER-PROMPTS.md`.

Shared deployment is maintained in `Common/omarchy/themes` in RWR blueprints.

Upscaling: Real-ESRGAN x4plus at 4×, then Lanczos reduction to 3840×2160.
The results were visually reviewed before application. Real-ESRGAN source:
https://github.com/xinntao/Real-ESRGAN

## Full desktop integration

Minecraft now includes a custom inventory lock layout with pixel clock,
health hearts, nine-item hotbar and the plugin's original password/fingerprint
controls; a grass-block menu logo; pixel folder/app icons with inherited
fallback coverage; GTK 3/4 and libadwaita colors with square beveled controls; matching Qt 5/6
Fusion palettes and stylesheets; and Creeper screensaver branding.

Integration is applied by `~/.config/omarchy/hooks/theme-set.d/90-minecraft-integration`
and restored when selecting another theme. A post-boot hook reapplies the
selected Minecraft integration after login. State backups are kept under
`~/.local/state/omarchy/minecraft-integration/`. The shared implementation is
`~/.config/omarchy/minecraft-integration/apply.py`; the custom lock design is
`~/.config/omarchy/lock-designs/Minecraft.qml`, and the user-owned menu clone
is `~/.config/omarchy/plugins/levi.menu/`.

The display font is Press Start 2P (SIL Open Font License); body/editor fonts
remain readable. Qt integration uses the small qt5ct/qt6ct packages. Reopen
existing GTK/Qt application windows to load their new application styles.
The lock layout does not alter authentication or replace PAM handling.
