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
  bindings.map.normal("<c-left>",  "<c-w>h")
  bindings.map.normal("<c-right>", "<c-w>l")
  bindings.map.normal("<c-up>",    "<c-w>k")
  bindings.map.normal("<c-down>",  "<c-w>j")

  -- swap windows
  bindings.map.normal("<leader>'", "<c-w>r")
  bindings.map.normal("<leader>;", "<c-w>R")

  -- reformat windows
  bindings.map.normal("<s-left>",  "<cmd>wincmd H<cr>")
  bindings.map.normal("<s-right>", "<cmd>wincmd L<cr>")
  bindings.map.normal("<s-up>",    "<cmd>wincmd K<cr>")
  bindings.map.normal("<s-down>",  "<cmd>wincmd J<cr>")

end
registry.defer(modern_split)


-- modern wm
local wm_close = function ()

  -- close window
  bindings.map.normal("<leader>w", "<cmd>close<cr>")

  local keep_open = set.new{}

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
  bindings.map.normal("<leader>W", [[:lua lv.window_only()<cr>]])

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


local quickfix_wm = function ()

  lv.toggle_quickfix = function ()
    local windows = api.nvim_tabpage_list_wins(0)
    local closed = false
    for _, window in ipairs(windows) do
      local buf = api.nvim_win_get_buf(window)
      local ft = api.nvim_buf_get_option(buf, "filetype")
      if ft == "qf" then
        api.nvim_win_close(window, true)
        closed = true
      end
    end
    if not closed then
      bindings.exec[[copen]]
      local height = vim.o.previewheight
      api.nvim_win_set_height(0, height)
    end
  end

  lv.clear_quickfix = function ()
    fn.setqflist({})
    bindings.exec[[cclose]]
  end

  bindings.map.normal("<leader>l", "<cmd>lua lv.clear_quickfix()<cr>")
  bindings.map.normal("<leader>L", "<cmd>lua lv.toggle_quickfix()<cr>")

  bindings.map.normal("<c-j>", "<cmd>cprevious<cr>")
  bindings.map.normal("<c-k>", "<cmd>cnext<cr>")

end
registry.defer(quickfix_wm)


local preview_wm = function ()

  -- preview height
  bindings.set("previewheight", 15)

  -- toggle preview
  lv.toggle_preview = function ()
    local closed = false
    for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
      if api.nvim_win_get_option(win, "previewwindow") then
        api.nvim_win_close(win, true)
        closed = true
      end
    end
    if not closed then
      bindings.exec[[new]]
      local height = vim.o.previewheight
      vim.wo.previewwindow = true
      api.nvim_win_set_height(0, height)
    end
  end

  bindings.map.normal("<leader>M", "<cmd>lua lv.toggle_preview()<cr>")

  lv.resize_preview = function ()
    local height = vim.o.previewheight
    local windows = api.nvim_tabpage_list_wins(0)

    for _, win in ipairs(windows) do
      local buf = api.nvim_win_get_buf(win)
      local ft = api.nvim_buf_get_option(buf, "filetype")

      if ft == "qf" then
          api.nvim_win_set_height(win, height)
      end

      if api.nvim_win_get_option(win, "previewwindow") then
        api.nvim_win_set_height(win, height)
      end
    end
  end

  -- resize preview
  bindings.map.normal("<leader>m", "<cmd>lua lv.resize_preview()<cr>")

end
registry.defer(preview_wm)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("<leader>X", "<cmd>bwipeout!<cr>")

end
registry.defer(buffers)
