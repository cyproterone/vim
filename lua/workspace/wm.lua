local bindings = require "libs/bindings"


local defer = {}
local plugins = {}

--#################### Intrinsic WM Region ####################

local misc = function ()

  -- hide background buffers
  bindings.set("hidden")

end


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
  bindings.map.normal("<M-Left>",  "<C-w>h")
  bindings.map.normal("<M-Right>", "<C-w>l")
  bindings.map.normal("<M-Up>",    "<C-w>k")
  bindings.map.normal("<M-Down>",  "<C-w>j")

end
table.insert(defer, modern_split)


-- modern wm
local wm_close = function ()

  -- close window
  bindings.map.normal("<Leader>w", ":close<CR>")

  -- close other windows
  bindings.map.normal("<Leader>W", ":only<CR>")

  -- break window into tab
  bindings.map.normal("<Leader>k", "<C-w>T")

end
table.insert(defer, wm_close)


-- tabs wm
local tabs_wm = function ()

  -- close tab
  bindings.map.normal("<Leader>q", ":tabclose<CR>")

  -- create new tab
  bindings.map.normal("<Leader>t", ":tabnew<CR>")

  -- cycle between tabs
  bindings.map.normal("<Leader>[", ":tabprevious<CR>")
  bindings.map.normal("<Leader>]", ":tabnext<CR>")

  for i = 1,9
  do
    bindings.map.normal("<Leader>" .. i, ":tabnext " .. i .. "<CR>")
  end

end
table.insert(defer, tabs_wm)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("<Leader>D", ":bwipeout!<CR>")

end
table.insert(defer, buffers)


return {
  plugins = plugins,
  defer = defer,
}
