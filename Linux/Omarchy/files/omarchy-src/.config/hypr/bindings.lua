-- Personal keybinds for Omarchy/Hyprland. Deployed by rwr (profile: omarchy)
-- into ~/.config/hypr/bindings.lua - Omarchy owns everything else and this
-- file survives its upgrades.
--
-- Bind sets are kept consistent across the DEs configured in this repo
-- (COSMIC, Cinnamon, Hyprland):
--   Ctrl+Alt+arrows        switch workspace
--   Ctrl+Alt+Shift+arrows  move window to prev/next workspace
--   Ctrl+Shift+arrows      focus window in direction
--   Super+arrows           move window in direction
--   Super+Shift+arrows     swap window (Omarchy default, untouched)
--   Super+numpad 4/6/8/2   focus monitor left/right/up/down
--
-- Override pattern per Omarchy docs: hl.unbind the default first, then
-- o.bind the replacement. All forms below verified live on Omarchy 4.0.2 /
-- Hyprland 0.56.2 (KP_* keysyms bind natively; no code:N fallback needed).

-- Super+arrows: move window. Omarchy defaults these to window focus - unbind
-- first or both register.
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
o.bind("SUPER + LEFT", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("SUPER + RIGHT", "Move window right", hl.dsp.window.move({ direction = "r" }))
o.bind("SUPER + UP", "Move window up", hl.dsp.window.move({ direction = "u" }))
o.bind("SUPER + DOWN", "Move window down", hl.dsp.window.move({ direction = "d" }))

-- Workspaces: cycle, and carry the focused window along with Shift.
o.bind("CTRL + ALT + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
o.bind("CTRL + ALT + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
o.bind("CTRL + ALT + SHIFT + LEFT", "Move window to previous workspace", hl.dsp.window.move({ workspace = "e-1" }))
o.bind("CTRL + ALT + SHIFT + RIGHT", "Move window to next workspace", hl.dsp.window.move({ workspace = "e+1" }))

-- Window focus: moved off Super+arrows to keep move there; matches the COSMIC
-- config's Ctrl+Shift focus binds.
o.bind("CTRL + SHIFT + LEFT", "Focus left window", hl.dsp.focus({ direction = "l" }))
o.bind("CTRL + SHIFT + RIGHT", "Focus right window", hl.dsp.focus({ direction = "r" }))
o.bind("CTRL + SHIFT + UP", "Focus above window", hl.dsp.focus({ direction = "u" }))
o.bind("CTRL + SHIFT + DOWN", "Focus below window", hl.dsp.focus({ direction = "d" }))

-- Monitor focus on the numpad: 4 left, 6 right, 8 up, 2 down.
o.bind("SUPER + KP_4", "Focus monitor left", hl.dsp.focus({ monitor = "l" }))
o.bind("SUPER + KP_6", "Focus monitor right", hl.dsp.focus({ monitor = "r" }))
o.bind("SUPER + KP_8", "Focus monitor up", hl.dsp.focus({ monitor = "u" }))
o.bind("SUPER + KP_2", "Focus monitor down", hl.dsp.focus({ monitor = "d" }))
