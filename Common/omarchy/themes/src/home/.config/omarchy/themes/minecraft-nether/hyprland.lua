-- Theme-local block geometry; Omarchy restores its defaults on theme switch.
local active = { colors = { "rgba(eda66aff)", "rgba(87c9c0dd)" }, angle = 45 }
hl.config({
 general = { border_size = 2, col = { active_border = active, inactive_border = "rgba(352724dd)" } },
 decoration = { rounding = 0, shadow = { enabled = true, range = 12, render_power = 3, color = "rgba(00000077)" } },
 group = { col = { border_active = active, border_inactive = "rgba(352724dd)" },
  groupbar = { text_color = "rgb(fff0dd)", text_color_inactive = "rgb(ad9282)",
   col = { active = "rgba(4d332bff)", inactive = "rgba(211a19ff)" } } },
})

-- Minecraft application theme integration, reset by Omarchy defaults.
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
