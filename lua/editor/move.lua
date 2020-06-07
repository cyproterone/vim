local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Cursors Region ####################

local get_visual = function ()
  local r1, c1 = unpack(api.nvim_buf_get_mark(0, "<"))
  local r2, c2 = unpack(api.nvim_buf_get_mark(0, ">"))
  return r1 , c1, r2, c2
end


local select_visual = function (r1, c1, r2, c2)
  print(r1, c1, r2, c2)
  fn.setpos("'<", {0, r1, c1 + 1, 0})
  fn.setpos("'>", {0, r2, c2 + 1, 0})
end


lv.move_up = function ()
  local r, c = unpack(api.nvim_win_get_cursor(0))
  if r <= 1 then
    return
  end
  r = r - 1
  local curr = api.nvim_buf_get_lines(0, r, r + 1, true)
  local nxt  = api.nvim_buf_get_lines(0, r - 1, r, true)
  local new = std.concat{curr, nxt}
  api.nvim_buf_set_lines(0, r - 1, r + 1, true, new)
  api.nvim_win_set_cursor(0, {r, c})
end


lv.move_down = function ()
  local r, c = unpack(api.nvim_win_get_cursor(0))
  if r >= api.nvim_buf_line_count(0) then
    return
  end
  r = r - 1
  local curr = api.nvim_buf_get_lines(0, r, r + 1, true)
  local nxt  = api.nvim_buf_get_lines(0, r + 1, r + 2, true)
  local new = std.concat{nxt, curr}
  api.nvim_buf_set_lines(0, r, r + 2, true, new)
  api.nvim_win_set_cursor(0, {r + 2, c})
end


lv.move_v_up = function ()
  local r1, c1, r2, c2 = get_visual()
  if r1 <= 1 then
    bindings.norm[[gv]]
    return
  end
  r1, r2 = r1 - 1, r2 - 1

  local curr = api.nvim_buf_get_lines(0, r1, r2 + 1, true)
  local nxt  = api.nvim_buf_get_lines(0, r1 - 1, r1, true)
  local new = std.concat{curr, nxt}
  api.nvim_buf_set_lines(0, r1 - 1, r2 + 1, true, new)

  select_visual(r1, c1, r2, c2)
  bindings.norm[[gv]]
end


lv.move_v_down = function ()
  local r1, c1, r2, c2 = get_visual()
  if r2 >= api.nvim_buf_line_count(0) then
    bindings.norm[[gv]]
    return
  end
  r1, r2 = r1 - 1, r2 - 1

  local curr = api.nvim_buf_get_lines(0, r1, r2 + 1, true)
  local nxt  = api.nvim_buf_get_lines(0, r2 + 1, r2 + 2, true)
  local new = std.concat{nxt, curr}
  api.nvim_buf_set_lines(0, r1, r2 + 2, true, new)

  select_visual(r1 + 2, c1, r2 + 2, c2)
  bindings.norm[[gv]]
end


-- drag regions around
local vim_move = function ()

  bindings.map.normal("<M-Up>",   ":lua lv.move_up()<CR>")
  bindings.map.normal("<M-Down>", ":lua lv.move_down()<CR>")

  bindings.map.visual("<M-Up>",   "<Esc>:lua lv.move_v_up()<CR>")
  bindings.map.visual("<M-Down>", "<Esc>:lua lv.move_v_down()<CR>")

end
registry.defer(vim_move)


-- indent
local indent = function ()

  -- keep selected when indenting
  bindings.map.visual("<", "<gv")
  bindings.map.visual(">", ">gv")

end
registry.defer(indent)
