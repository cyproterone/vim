--#################### ############## ####################
--#################### Project Region ####################
--#################### ############## ####################
require "libs/set"


proj = function ()

  local plugins = {}
  local defer = {}


  -- consistent coding style
  table.insert(
    plugins,
    "editorconfig/editorconfig-vim")


  return {
    plugins = plugins,
    defer = defer,
  }
end
