-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Navigate adjacent numbered workspaces, including empty ones.
o.bind("CTRL + ALT + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "-1" }))
o.bind("CTRL + ALT + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "+1" }))

-- Move the active window to the adjacent workspace and follow it.
o.bind("CTRL + SHIFT + ALT + LEFT", "Move window to previous workspace", hl.dsp.window.move({ workspace = "-1", follow = true }))
o.bind("CTRL + SHIFT + ALT + RIGHT", "Move window to next workspace", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Replace grouped-window focus with directional tile swaps.
hl.unbind("SUPER + CTRL + LEFT")
hl.unbind("SUPER + CTRL + RIGHT")
o.bind("SUPER + CTRL + LEFT", "Swap window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + CTRL + RIGHT", "Swap window right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + CTRL + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + CTRL + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Bind both numpad symbols: works with Num Lock either on or off.
o.bind("SUPER + CTRL + KP_4", "Swap window left (numpad 4)", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + CTRL + KP_Left", "Swap window left (numpad 4)", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + CTRL + KP_6", "Swap window right (numpad 6)", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + CTRL + KP_Right", "Swap window right (numpad 6)", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + CTRL + KP_8", "Swap window up (numpad 8)", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + CTRL + KP_Up", "Swap window up (numpad 8)", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + CTRL + KP_2", "Swap window down (numpad 2)", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + CTRL + KP_Down", "Swap window down (numpad 2)", hl.dsp.window.swap({ direction = "d" }))

-- Corner placement retiles the current workspace using dwindle as needed.
local place_corner = dofile(os.getenv("HOME") .. "/.config/hypr/corner-placement.lua")
o.bind("SUPER + CTRL + KP_7", "Tile window top left (numpad 7)", function() place_corner("l", "u") end)
o.bind("SUPER + CTRL + KP_Home", "Tile window top left (numpad 7)", function() place_corner("l", "u") end)
o.bind("SUPER + CTRL + KP_9", "Tile window top right (numpad 9)", function() place_corner("r", "u") end)
o.bind("SUPER + CTRL + KP_Prior", "Tile window top right (numpad 9)", function() place_corner("r", "u") end)
o.bind("SUPER + CTRL + KP_1", "Tile window bottom left (numpad 1)", function() place_corner("l", "d") end)
o.bind("SUPER + CTRL + KP_End", "Tile window bottom left (numpad 1)", function() place_corner("l", "d") end)
o.bind("SUPER + CTRL + KP_3", "Tile window bottom right (numpad 3)", function() place_corner("r", "d") end)
o.bind("SUPER + CTRL + KP_Next", "Tile window bottom right (numpad 3)", function() place_corner("r", "d") end)
