local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Syntax Region ####################

-- registry.install("nvim-treesitter/nvim-treesitter")
local tree_sitter = function ()

  -- bindings.exec[[lua lv.tmp = require("nvim-treesitter.configs")]]
  -- local ts = lv.tmp
  -- lv.tmp = nil
  -- ts.setup{}

end
registry.defer(tree_sitter)
