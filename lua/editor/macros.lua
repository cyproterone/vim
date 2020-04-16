--#################### ############# ####################
--#################### Macros Region ####################
--#################### ############# ####################
require "libs/set"


macros = function ()

  local commands = {}
  local plugins = {}

  table.insert(plugins, "tpope/vim-repeat")

  return {
    commands = commands,
    plugins = plugins
  }
end
