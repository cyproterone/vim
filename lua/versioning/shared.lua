local bindings = require "libs/bindings"

local plugins = {}
local defer = {}
local functions = {}

--#################### Shared Region ####################

-- vc gutter
table.insert(plugins, "mhinz/vim-signify")
local gutter = function ()

  bindings.map.normal("<Leader>hd", ":SignifyHunkDiff<CR>")
  bindings.map.normal("<Leader>hD", ":SignifyDiff<CR>")
  bindings.map.normal("<Leader>hu", ":SignifyHunkUndo<CR>")

end
table.insert(defer, gutter)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}

