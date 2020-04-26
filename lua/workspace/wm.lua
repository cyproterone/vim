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

end
table.insert(defer, wm_close)


--#################### Intrinsic Buffers Region ####################

-- buffer region
local buffers = function ()

  bindings.map.normal("D", ":bd!<CR>")

end
table.insert(defer, buffers)


--#################### WM Region ####################

-- swap windows
table.insert(plugins, "wesQ3/vim-windowswap")
local win_swap = function ()

end
table.insert(defer, win_swap)


return {
  plugins = plugins,
  defer = defer,
}
