local std = require "libs/std"
local set = require "libs/set"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


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
  bindings.map.normal("<Leader>=", ":vsplit<CR>")
  bindings.map.normal("<Leader>-", ":split<CR>")

  -- has to use C for direction
  bindings.map.normal("<C-h>", "<C-w>h")
  bindings.map.normal("<C-l>", "<C-w>l")
  bindings.map.normal("<C-k>", "<C-w>k")
  bindings.map.normal("<C-j>", "<C-w>j")

  -- has to use M for direction
  bindings.map.normal("<C-Left>",  "<C-w>h")
  bindings.map.normal("<C-Right>", "<C-w>l")
  bindings.map.normal("<C-Up>",    "<C-w>k")
  bindings.map.normal("<C-Down>",  "<C-w>j")

end
registry.defer(modern_split)


local new_window = function ()
end


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
      local ft = bindings.buf(buf).opt("filetype")
      if win ~= only_win and not set.contains(keep_open, ft) then
        api.nvim_win_close(win, false)
      end
    end
  end
  bindings.map.normal("<Leader>W", [[:lua lua_window_only{"defx"}<CR>]])

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
    local buf = api.nvim_get_current_buf()
    bindings.buf(0).set("buftype", "nofile")
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
