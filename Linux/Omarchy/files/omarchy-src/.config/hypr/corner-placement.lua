-- Insert the focused tile at the requested corner of its workspace.
return function(horizontal, vertical)
  local w = hl.get_active_window()
  if not w or w.floating or not w.workspace or w.workspace.has_fullscreen then return end
  local ws = w.workspace
  local function tiles()
    local result = {}
    for _, candidate in ipairs(hl.get_windows()) do
      if candidate.mapped and not candidate.hidden and not candidate.floating
          and candidate.workspace and candidate.workspace.id == ws.id then
        result[#result + 1] = candidate
      end
    end
    return result
  end
  if #tiles() < 2 then return end
  if ws.tiled_layout ~= "dwindle" then
    hl.workspace_rule({ workspace = tostring(ws.id), layout = "dwindle" })
  end
  local windows = tiles()
  local left, top, right, bottom = math.huge, math.huge, -math.huge, -math.huge
  for _, candidate in ipairs(windows) do
    local p, s = candidate.at, candidate.size
    left, top = math.min(left, p.x), math.min(top, p.y)
    right, bottom = math.max(right, p.x + s.x), math.max(bottom, p.y + s.y)
  end
  local x = horizontal == "l" and left or right
  local y = vertical == "u" and top or bottom
  local target, best = nil, math.huge
  for _, candidate in ipairs(windows) do
    local p, s = candidate.at, candidate.size
    local dx = math.max(p.x - x, 0, x - p.x - s.x)
    local dy = math.max(p.y - y, 0, y - p.y - s.y)
    local distance = dx * dx + dy * dy
    if distance < best then target, best = candidate, distance end
  end
  -- Already occupies that corner: don't repeatedly subdivide the same area.
  if not target or target.address == w.address then return end
  local old_active = hl.get_config("dwindle.use_active_for_splits")
  local old_preserve = hl.get_config("dwindle.preserve_split")
  local ok, err = pcall(function()
    hl.config({ dwindle = { use_active_for_splits = true, preserve_split = true } })
    hl.dispatch(hl.dsp.window.float({ window = w, action = "set" }))
    -- Removing a full-height side can collapse the remaining column into
    -- a full-width vertical stack. Restore a side-by-side split first.
    if #windows > 2 and target.size.x > (right - left) * 0.9 then
      hl.dispatch(hl.dsp.focus({ window = target }))
      hl.dispatch(hl.dsp.layout("togglesplit"))
      best = math.huge
      for _, candidate in ipairs(tiles()) do
        local p, s = candidate.at, candidate.size
        local dx = math.max(p.x - x, 0, x - p.x - s.x)
        local dy = math.max(p.y - y, 0, y - p.y - s.y)
        local distance = dx * dx + dy * dy
        if distance < best then target, best = candidate, distance end
      end
    end
    hl.dispatch(hl.dsp.focus({ window = target }))
    hl.dispatch(hl.dsp.layout("preselect " .. vertical))
    hl.dispatch(hl.dsp.window.float({ window = w, action = "unset" }))
    hl.dispatch(hl.dsp.focus({ window = w }))
    hl.dispatch(hl.dsp.layout("splitratio 1.0 exact"))
  end)
  hl.config({ dwindle = { use_active_for_splits = old_active, preserve_split = old_preserve } })
  if not ok then
    -- Keep the window tiled and usable if a dispatcher fails midway.
    hl.dispatch(hl.dsp.window.float({ window = w, action = "unset" }))
    hl.dispatch(hl.dsp.focus({ window = w }))
    error(err)
  end
end
