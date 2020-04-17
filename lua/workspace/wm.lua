local bindings = require "libs/bindings"


local defer = {}
local plugins = {}

--#################### Intrinsic Region ####################

local misc = function ()

  -- hide unused buffers
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
  bindings.map.normal("<Leader><Left>",  "<C-w>h")
  bindings.map.normal("<Leader><Right>", "<C-w>l")
  bindings.map.normal("<Leader><Up>",    "<C-w>k")
  bindings.map.normal("<Leader><Down>",  "<C-w>j")
  
end
table.insert(defer, modern_split)


--#################### WM Region ####################

-- swap windows
table.insert(plugins, "wesQ3/vim-windowswap")
local win_swap = function ()

end
table.insert(defer, win_swap)


-- resize active window
table.insert(plugins, "roman/golden-ratio")
local lens = function ()

  -- exclude certain windows from being resized
  bindings.let("golden_ratio_exclude_nonmodifiable", 1)

end
table.insert(defer, lens)


return {
  plugins = plugins,
  defer = defer,
}
