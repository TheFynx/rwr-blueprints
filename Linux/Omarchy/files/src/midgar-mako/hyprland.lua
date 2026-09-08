-- Theme-local: restored by Omarchy's defaults on the next theme reload.
local active = { colors = { "rgba(63e6beee)", "rgba(79d8deee)", "rgba(bc9be7cc)" }, angle = 45 }
hl.config({
  general = { border_size = 2, col = { active_border = active, inactive_border = "rgba(30464dcc)" } },
  decoration = { rounding = 4, shadow = { enabled = true, range = 16, render_power = 3, color = "rgba(05080b88)" } },
  group = {
    col = { border_active = active, border_inactive = "rgba(30464dcc)" },
    groupbar = { text_color = "rgb(f0faf7)", text_color_inactive = "rgb(82979e)",
      col = { active = "rgba(264b4cee)", inactive = "rgba(101d28ee)" } },
  },
})
