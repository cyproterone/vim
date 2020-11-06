local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Syntax Region ####################

registry.install("nvim-treesitter/nvim-treesitter")
registry.install("nvim-treesitter/nvim-treesitter-textobjects")
local tree_sitter = function ()

  -- local ts = require("nvim-treesitter.configs")
  -- ts.setup{}

end
registry.defer(tree_sitter)
