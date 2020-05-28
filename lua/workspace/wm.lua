local bindings = require "libs/bindings"
local registry = require "libs/registry"
local set = require "libs/set"
local std = require "libs/std"


--#################### Intrinsic WM Region ####################

local misc = function ()

  -- hide background buffers
  bindings.set("hidden")

end
registry.defer(misc)


-- modern split direction
local modern_split = function ()

  bindings.set("splitright")
  bindings.set("splitbelow")

  -- split windows
  lua_new_window = function(vertical)
    if vertical then
      bindings.exec[[vnew]]
    else
      bindings.exec[[new]]
    end
    local buf = api.nvim_create_buf(false, true)
    api.nvim_win_set_buf(0, buf)
  end
  bindings.map.normal("<Leader>=", ":lua lua_new_window(true)<CR>")
  bindings.map.normal("<Leader>-", ":lua lua_new_window(false)<CR>")

  -- move between windows
  bindings.map.normal("<C-Left>",  "<C-w>h")
  bindings.map.normal("<C-Right>", "<C-w>l")
  bindings.map.normal("<C-Up>",    "<C-w>k")
  bindings.map.normal("<C-Down>",  "<C-w>j")

  -- swap windows
  bindings.map.normal("<Leader>'", "<C-w>r")
  bindings.map.normal("<Leader>;", "<C-w>R")

  -- reformat windows
  bindings.map.normal("<S-Left>",  "<C-w>H")
  bindings.map.normal("<S-Right>", "<C-w>L")
  bindings.map.normal("<S-Up>",    "<C-w>K")
  bindings.map.normal("<S-Down>",  "<C-w>J")

end
registry.defer(modern_split)


-- modern wm
local wm_close = function ()

  -- quit vim
  bindings.map.normal("QQ", ":qa<CR>")

  -- close window
  bindings.map.normal("<Leader>w", ":close<CR>")

  -- close other windows
  lua_window_only = function (keep_open)
    local keep_open = set.new(keep_open)
    local only_win = api.nvim_tabpage_get_win(0)
    local wins = api.nvim_tabpage_list_wins(0)

    for _, win in ipairs(wins) do
      local buf = api.nvim_win_get_buf(win)
      local ft = api.nvim_buf_get_option(buf, "filetype")
      if win ~= only_win and not set.contains(keep_open, ft) then
        api.nvim_win_close(win, false)
      end
    end
  end
  bindings.map.normal("<Leader>W", [[:lua lua_window_only{"defx", "qf"}<CR>]])

  -- break window into tab
  bindings.map.normal("<Leader>k", "<C-w>T")

end
registry.defer(wm_close)


-- tabs wm
local tabs_wm = function ()

  -- close tab
  bindings.map.normal("<Leader>q", ":tabclose<CR>")

  -- create new tab
  lua_new_tab = function ()
    bindings.exec[[tabnew]]
    vim.bo.buftype = "nofile"
  end
  bindings.map.normal("<Leader>t", ":lua lua_new_tab()<CR>")
  bindings.map.normal("<Leader>n", ":lua lua_new_tab()<CR>")

  -- cycle between tabs
  bindings.map.normal("<Leader>[", ":tabprevious<CR>")
  bindings.map.normal("<Leader>]", ":tabnext<CR>")

  bindings.map.normal("<Leader>0", "g<Tab>")
  for i in std.range(1, 9) do
    bindings.map.normal("<Leader>" .. i, ":tabnext " .. i .. "<CR>")
  end

end
registry.defer(tabs_wm)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("<Leader>X", ":bwipeout!<CR>")

end
registry.defer(buffers)
