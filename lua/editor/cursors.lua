local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Cursors Region ####################

local get_visual = function ()
  local r1, c1 = unpack(api.nvim_buf_get_mark(0, "<"))
  local r2, c2 = unpack(api.nvim_buf_get_mark(0, ">"))
  return r1 - 1, c1, r2 - 1, c2
end


local select_visual = function ()
end


lua_move_up = function ()
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


lua_move_down = function ()
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


lua_move_v_down = function ()
  local r1, c1, r2, c2 = get_visual()
  local r, c = unpack(api.nvim_win_get_cursor(0))
  api.nvim_win_set_cursor(0, {r - 1, c})
  select_visual()
end


lua_move_v_up = function ()
  local r1, c1, r2, c2 = get_visual()
  local r, c = unpack(api.nvim_win_get_cursor(0))
  api.nvim_win_set_cursor(0, {r + 1, c})
  select_visual()
end


-- drag regions around
local vim_move = function ()

  bindings.map.normal("<M-Up>",   ":lua lua_move_up()<CR>")
  bindings.map.normal("<M-Down>", ":lua lua_move_down()<CR>")

  bindings.map.visual("<M-Up>",   "<Esc>:lua lua_move_v_up()<CR>")
  bindings.map.visual("<M-Down>", "<Esc>:lua lua_move_v_down()<CR>")

end
registry.defer(vim_move)

