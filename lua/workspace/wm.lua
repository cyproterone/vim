local bindings = require "libs/bindings"


local defer = {}
local plugins = {}

--#################### Intrinsic Region ####################

-- modern split direction
local modern_split = function ()

  bindings.set("splitright")
  bindings.set("splitbelow")

  -- split windows
  bindings.map.normal("<M-=>", ":vsplit<CR>")
  bindings.map.normal("<M-->", ":split<CR>")

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


--#################### WM Region ####################

-- swap windows
table.insert(plugins, "wesQ3/vim-windowswap")


-- resize active window
table.insert(plugins, "roman/golden-ratio")
local lens = function ()
end
table.insert(defer, lens)


return {
  plugins = plugins,
  defer = defer,
}
