# Adaptive Cloud screensaver

`cloud-original.txt` preserves the supplied 159×105 shade-character drawing. `fit-cloud.py` uniformly fits text to the PTY with margins using area-weighted shade averaging when reduction is needed. At sufficient size it preserves every original non-padding character. No bitmap assets are edited.

`run` is invoked by Omarchy's stock screensaver launcher. It waits for stable terminal geometry, starts a 30fps Mako gradient centered on the full canvas, and refits on resize. Keyboard input or focus loss exits and restores the cursor.

`screensaver.txt` is a compact fallback installed by the theme-set branding hook.

Live verification: `/home/levi/Work/midgar-mako-backups/screenshot-2026-09-08_09-44-42.png`.
