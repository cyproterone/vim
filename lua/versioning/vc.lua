local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Version Control Region ####################

-- signs
registry.install("mhinz/vim-signify")
local signify = function ()

  -- undo
  bindings.map.normal("<Leader>hu", ":SignifyHunkUndo<CR>")

  -- hunk diff
  bindings.map.normal("<Leader>hp", ":SignifyHunkDiff<CR>")

  -- whole page diff
  bindings.map.normal("<Leader>hd", ":SignifyDiff<CR>")

end
registry.defer(signify)
