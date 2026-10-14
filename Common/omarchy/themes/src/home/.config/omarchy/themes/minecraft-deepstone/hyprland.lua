-- Theme-local block geometry; Omarchy restores its defaults on theme switch.
local active = { colors = { "rgba(91c96aff)", "rgba(78d5cedd)" }, angle = 45 }
hl.config({
 general = { border_size = 2, col = { active_border = active, inactive_border = "rgba(27312bdd)" } },
 decoration = { rounding = 0, shadow = { enabled = true, range = 12, render_power = 3, color = "rgba(00000077)" } },
 group = { col = { border_active = active, border_inactive = "rgba(27312bdd)" },
  groupbar = { text_color = "rgb(f3f5e8)", text_color_inactive = "rgb(8b9989)",
   col = { active = "rgba(314731ff)", inactive = "rgba(171d1bff)" } } },
})

-- Minecraft application theme integration, reset by Omarchy defaults.
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
