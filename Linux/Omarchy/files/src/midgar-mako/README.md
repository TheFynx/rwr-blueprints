# Midgar Mako

A complete, user-owned Final Fantasy VII theme for Omarchy Quattro. Midnight steel and silver form the working surfaces; Mako mint signals focus, cyan and violet suggest linked materia, faded gold marks alerts and tooltips, and red remains reserved for errors.

## Desktop design

- Native `shell.toml` styles all 13 shell sections: bar, shared borders, controls, spacing, typography, popups, tooltips, notifications, launcher, menus, authentication, lock input, and background picker.
- A 30px bar, deep blue menu cards, mint selected rows, silver text, gold tooltip outlines, and clear hover/focus states retain everyday readability.
- Native `hyprland.lua` supplies linked mint/cyan/violet borders, quiet inactive outlines, 4px corners, soft dark shadows, and matching grouped-window tabs. Omarchy's normal config reload restores defaults when switching themes.
- `colors.toml` remains the single palette for Omarchy's generated Alacritty, Foot, Ghostty, Kitty, btop, Chromium-family browser chrome, Helix, Neovim/Aether, VS Code, Obsidian, Claude, Pi, keyboard RGB, terminal menu colors, and preview-picker styles. Omarchy also synchronizes running terminal/tmux colors and GTK dark mode. Installed app/hardware support determines which integrations are visible.
- Yaru-sage icons match the green accents. Existing font preferences, keybindings, application behavior, and idle deadlines are retained.

## Backgrounds

Fourteen wallpapers participate in the normal theme background picker and rotation:

1. `backgrounds/midgar-mako.png`: original Cloud overlooking Midgar.
2. `backgrounds/sector-5-sanctuary.png`: moonlit church, flowers, and Aerith.
3. `backgrounds/lifestream.png`: luminous cavern and Cloud overlooking the planet's energy.
4. `backgrounds/cloud-vs-sephiroth.png`: a moonlit duel above Midgar.
5. `backgrounds/cloud-buster-sword.png`: Cloud with his sword planted on a rocky overlook.
6. `backgrounds/sephiroth-nibelheim.png`: Sephiroth walking through the flames.

Eight more solo portraits complete the original party: Tifa, Barret, Aerith, Red XIII, Yuffie, Cait Sith, Cid, and Vincent. See `party-wallpapers.md` for their filenames and settings.

The thirteen additional images were generated using the built-in image generation tool. Their actual delivered resolution is 1586×992 (approximately 16:10); Omarchy scales them to the display. Full prompts are in `background-prompts.md`, `character-wallpaper-prompts.md`, and `party-wallpaper-prompts.md`; the original prompt remains in `wallpaper-prompt.txt`.

```sh
omarchy theme bg next
```

## Screensaver

The original 159×105 shade-character drawing is preserved in `screensaver/cloud-original.txt`. Omarchy's stock idle service and screensaver launcher run the theme's `screensaver/run`. It waits for stable terminal geometry, fits the complete drawing with margins, and refits after a size change. A slow 30fps mint/cyan/violet gradient keeps the artwork visible throughout the animation.

```sh
omarchy launch screensaver force
```

The theme also supplies a compact 30-row fallback drawing for Omarchy branding. A theme-set hook saves and restores the prior branding without modifying packaged Omarchy files.

The desktop blueprint keeps Omarchy's stock idle service and configures the screensaver at 300 seconds and lock at 360 seconds.

## Apply and maintain

RWR installs this source as `~/.config/omarchy/themes/midgar-mako`, installs the branding hook, and activates the theme through the Omarchy configuration provider.

```sh
rwr run configuration
# Reapply the installed theme directly when working on it:
omarchy theme set midgar-mako
```

A plain copy of this theme directory provides native visual styling on another Omarchy system. The adaptive renderer requires Python 3 and ttfx. No theme-specific package installs are required by this blueprint.

## Validation and backup

Verified TOML/JSON parsing, Lua and shell syntax, native Hyprland reload with no config errors, theme-hook activate/reapply/restore, and artwork fitting at six terminal sizes. A live full-screen capture confirms the complete centered figure, sword, and boots. The full original text is retained at native display dimensions.

RWR records the theme and hook resources it manages and preserves protected prior files in its Omarchy state directory.

To select a different theme, use `omarchy theme set <name>`; custom styling follows the selected theme and the branding hook restores the saved prior branding. Change the blueprint's active theme to make that selection repeatable.
