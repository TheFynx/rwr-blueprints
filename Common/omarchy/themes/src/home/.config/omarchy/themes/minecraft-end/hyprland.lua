-- Theme-local block geometry; Omarchy restores its defaults on theme switch.
local active = { colors = { "rgba(bd9ae6ff)", "rgba(9bd5d2dd)" }, angle = 45 }
hl.config({
 general = { border_size = 2, col = { active_border = active, inactive_border = "rgba(30283edd)" } },
 decoration = { rounding = 0, shadow = { enabled = true, range = 12, render_power = 3, color = "rgba(00000077)" } },
 group = { col = { border_active = active, border_inactive = "rgba(30283edd)" },
  groupbar = { text_color = "rgb(f6efff)", text_color_inactive = "rgb(a496b3)",
   col = { active = "rgba(3d3155ff)", inactive = "rgba(1b1823ff)" } } },
})

-- Minecraft application theme integration, reset by Omarchy defaults.
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
