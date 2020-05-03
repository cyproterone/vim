local bindings = require "libs/bindings"
local registry = require "libs/registry"

--#################### Shared Region ####################

-- vc gutter
registry.install("mhinz/vim-signify")
local gutter = function ()

  bindings.map.normal("<Leader>hd", ":SignifyHunkDiff<CR>")
  bindings.map.normal("<Leader>hD", ":SignifyDiff<CR>")
  bindings.map.normal("<Leader>hu", ":SignifyHunkUndo<CR>")

end
registry.defer(gutter)
