require "libs/set"


macros = function ()

  local commands = {}
  local plugins = {}

  --#################### Macros Region ####################

  table.insert(plugins, "tpope/vim-repeat")

  return {
    commands = commands,
    plugins = plugins
  }
end
