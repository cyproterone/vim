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
  bindings.map.normal("<Leader>=", "<cmd>lua lv.new_window(true)<CR>")
  bindings.map.normal("<Leader>-", "<cmd>lua lv.new_window(false)<CR>")

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

  -- close window
  bindings.map.normal("<Leader>w", "<cmd>close<CR>")

  local keep_open = set.new{"qf", "defx"}

  -- close other windows
  lv.window_only = function (keep_open)
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
  bindings.map.normal("<Leader>W", [[:lua lv.window_only{}<CR>]])

  -- break window into tab
  bindings.map.normal("<Leader>k", "<C-w>T")

end
registry.defer(wm_close)


-- tabs wm
local tabs_wm = function ()

  -- close tab
  bindings.map.normal("<Leader>q", "<cmd>tabclose<CR>")

  -- create new tab
  lv.new_tab = function ()
    bindings.exec[[tabnew]]
    vim.bo.buftype = "nofile"
  end
  bindings.map.normal("<Leader>t", "<cmd>lua lv.new_tab()<CR>")
  bindings.map.normal("<Leader>n", "<cmd>lua lv.new_tab()<CR>")

  -- cycle between tabs
  bindings.map.normal("<Leader>[", "<cmd>tabprevious<CR>")
  bindings.map.normal("<Leader>]", "<cmd>tabnext<CR>")

  bindings.map.normal("<Leader>0", "g<Tab>")
  for i in std.range(1, 9) do
    bindings.map.normal("<Leader>" .. i, "<cmd>tabnext " .. i .. "<CR>")
  end

end
registry.defer(tabs_wm)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("<Leader>X", "<cmd>bwipeout!<CR>")

end
registry.defer(buffers)

