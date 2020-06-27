local bindings = require "libs/bindings"
local registry = require "libs/registry"
local set = require "libs/set"
local std = require "libs/std"


--#################### Intrinsic WM Region ####################

local misc = function ()

  -- hide background buffers
  bindings.set("hidden")

  -- reuse buf
  bindings.set("switchbuf", "useopen,usetab", [[+=]])

end
registry.defer(misc)


-- modern split direction
local modern_split = function ()

  bindings.set("splitright")
  bindings.set("splitbelow")

  -- split windows
  lv.new_window = function(vertical)
    if vertical then
      bindings.exec[[vnew]]
    else
      bindings.exec[[new]]
    end
    local buf = api.nvim_create_buf(false, true)
    api.nvim_win_set_buf(0, buf)
  end
  bindings.map.normal("<leader>=", "<cmd>lua lv.new_window(true)<cr>")
  bindings.map.normal("<leader>-", "<cmd>lua lv.new_window(false)<cr>")

  -- move between windows
  bindings.map.normal("<c-Left>",  "<c-w>h")
  bindings.map.normal("<c-Right>", "<c-w>l")
  bindings.map.normal("<c-Up>",    "<c-w>k")
  bindings.map.normal("<c-Down>",  "<c-w>j")

  -- swap windows
  bindings.map.normal("<leader>'", "<c-w>r")
  bindings.map.normal("<leader>;", "<c-w>R")

  -- reformat windows
  bindings.map.normal("<S-Left>",  "<c-w>H")
  bindings.map.normal("<S-Right>", "<c-w>L")
  bindings.map.normal("<S-Up>",    "<c-w>K")
  bindings.map.normal("<S-Down>",  "<c-w>J")

end
registry.defer(modern_split)


-- modern wm
local wm_close = function ()

  -- close window
  bindings.map.normal("<leader>w", "<cmd>close<cr>")

  local keep_open = set.new{"qf", "defx"}

  -- close other windows
  lv.window_only = function ()
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
  bindings.map.normal("<leader>W", [[:lua lv.window_only{}<cr>]])

  -- break window into tab
  bindings.map.normal("<leader>k", "<c-w>T")

end
registry.defer(wm_close)


-- tabs wm
local tabs_wm = function ()

  -- close tab
  bindings.map.normal("<leader>q", "<cmd>tabclose<cr>")

  -- create new tab
  lv.new_tab = function ()
    bindings.exec[[tabnew]]
    vim.bo.buftype = "nofile"
  end
  bindings.map.normal("<leader>t", "<cmd>lua lv.new_tab()<cr>")
  bindings.map.normal("<leader>n", "<cmd>lua lv.new_tab()<cr>")

  -- cycle between tabs
  bindings.map.normal("<leader>[", "<cmd>tabprevious<cr>")
  bindings.map.normal("<leader>]", "<cmd>tabnext<cr>")

  bindings.map.normal("<leader>0", "g<tab>")
  for i in std.range(1, 9) do
    bindings.map.normal("<leader>" .. i, "<cmd>tabnext " .. i .. "<cr>")
  end

end
registry.defer(tabs_wm)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("<leader>X", "<cmd>bwipeout!<cr>")

end
registry.defer(buffers)
