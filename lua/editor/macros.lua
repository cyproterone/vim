require "libs/set"


macros = function ()

  local defer = {}
  local plugins = {}

  --#################### Macros Region ####################

  table.insert(
    plugins,
    "tpope/vim-repeat")

  return {
    defer = defer,
    plugins = plugins
  }
end
