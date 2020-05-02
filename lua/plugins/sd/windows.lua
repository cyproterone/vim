--#################### ############## ####################
--#################### Windows Region ####################
--#################### ############## ####################

local std = require "libs/std"
local m = math


local calibrate = function (win)
  api.nvim_win_set_option(win, "fillchars", "eob: ")
  api.nvim_win_set_option(win, "number", false)
  api.nvim_win_set_option(win, "relativenumber", false)
  api.nvim_win_set_option(win, "signcolumn", "no")
  api.nvim_win_set_option(win, "cursorcolumn", false)
  api.nvim_win_set_option(win, "foldcolumn", 0)
  api.nvim_win_set_option(win, "spell", false)
  api.nvim_win_set_option(win, "list", false)
end


local order = function (wins)
  local wins = std.map(wins, std.id)
  table.sort(wins, function (a, b)
    local _, col_a = unpack(api.nvim_win_get_position(a))
    local _, col_b = unpack(api.nvim_win_get_position(b))
    return col_a < col_b
  end)
  return wins
end


local new_tab = function (rel_size)
  api.nvim_command[[tabnew]]
  local tab = api.nvim_get_current_tabpage()
  api.nvim_command[[vsplit]]
  local wins = api.nvim_tabpage_list_wins(tab)
  std.foreach(wins, calibrate)
  local sidebar, main = unpack(order(wins))
  local width = api.nvim_get_option("columns")
  api.nvim_win_set_width(sidebar, m.ceil(width * rel_size))
  return {sidebar, main}
end


return {
  new_tab = new_tab
}
