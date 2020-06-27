local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Version Control Region ####################

-- signs
registry.install("mhinz/vim-signify")
local signify = function ()

  -- undo
  bindings.map.normal("<leader>hu", "<cmd>SignifyHunkUndo<cr>")

  -- hunk diff
  bindings.map.normal("<leader>hp", "<cmd>SignifyHunkDiff<cr>")

  -- whole page diff
  bindings.map.normal("<leader>hd", "<cmd>SignifyDiff<cr>")

end
registry.defer(signify)
