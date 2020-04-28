local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Shared Region ####################

-- vc gutter
table.insert(plugins, "mhinz/vim-signify")
local gutter = function ()

  bindings.map.normal("<Leader>sd", ":SignifyHunkDiff<CR>")
  bindings.map.normal("<Leader>sD", ":SignifyDiff<CR>")
  bindings.map.normal("<Leader>su", ":SignifyHunkUndo<CR>")

end
table.insert(defer, gutter)


return {
  plugins = plugins,
  defer = defer,
}

