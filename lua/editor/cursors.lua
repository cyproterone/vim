--#################### ############## ####################
--#################### Cursors Region ####################
--#################### ############## ####################
require "libs/set"


cursors = function ()

  local commands = {}
  local plugins = {}

  table.insert(plugins, "terryma/vim-expand-region")

  -- multi cursors
  table.insert(plugins, "terryma/vim-multiple-cursors")

  -- drag regions around
  table.insert(plugins, "matze/vim-move")

  -- easy quoting
  table.insert(plugins, "tpope/vim-surround")

  -- auto parens
  table.insert(plugins, "Raimondi/delimitMate")

  return {
    commands = commands,
    plugins = plugins
  }
end
