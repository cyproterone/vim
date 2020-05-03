--#################### ############## ####################
--#################### Windows Region ####################
--#################### ############## ####################

local std = require "libs/std"
local m = math
local c = require "plugins/sd/consts"


local order = function (wins)
  local wins = std.concat{wins}
  table.sort(wins, function (a, b)
    local row_a, col_a = unpack(api.nvim_win_get_position(a))
    local row_b, col_b = unpack(api.nvim_win_get_position(b))
    if col_a == col_b then
      return row_a < row_b
    else
      return col_a < col_b
    end
  end)
  return wins
end


local calibrate = function (win)
  api.nvim_win_set_option(win, "fillchars", "eob: ")
  api.nvim_win_set_option(win, "number", false)
  api.nvim_win_set_option(win, "relativenumber", false)
  api.nvim_win_set_option(win, "signcolumn", "no")
  api.nvim_win_set_option(win, "cursorcolumn", false)
  api.nvim_win_set_option(win, "cursorline", false)
  api.nvim_win_set_option(win, "foldcolumn", 0)
  api.nvim_win_set_option(win, "spell", false)
  api.nvim_win_set_option(win, "list", false)
end


local calibrate_editable = function (win, size)
  api.nvim_win_set_height(win, size)
end

local calibrate_listing = function (win)
  api.nvim_win_set_option(listing, "cursorline", true)
end


local new_tab = function (sidebar_size, input_size)
  api.nvim_command[[tabnew]]
  local tab = api.nvim_get_current_tabpage()
  api.nvim_command[[vsplit]]
  local wins = api.nvim_tabpage_list_wins(tab)
  local s = unpack(order(wins))

  api.nvim_set_current_win(s)
  local width = api.nvim_get_option("columns")
  api.nvim_win_set_width(s, m.ceil(width * sidebar_size))
  api.nvim_command[[split]]
  api.nvim_command[[split]]
  api.nvim_command[[split]]

  local wins = api.nvim_tabpage_list_wins(tab)
  local pattern, replace, mask, listing, main = unpack(wins)
  api.nvim_set_current_win(pattern)

  std.foreach(wins, calibrate)
  std.foreach({pattern, replace, mask}, function (win) 
    calibrate_editable(win, input_size)
  end)
  calibrate_listing(listing)

  return {
    pattern = pattern,
    replace = replace,
    mask = mask,
    listing = listing,
    main = main,
  }
end


return {
  new_tab = new_tab
}