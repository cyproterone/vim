--#################### ############## ####################
--#################### Project Region ####################
--#################### ############## ####################
require "libs/set"


proj = function ()

  local defer = {}
  local plugins = {}


  -- consistent coding style
  table.insert(
    plugins,
    "editorconfig/editorconfig-vim")


  return {
    defer = defer,
    plugins = plugins
  }
end
