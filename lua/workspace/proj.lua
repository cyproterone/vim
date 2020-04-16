--#################### ############## ####################
--#################### Project Region ####################
--#################### ############## ####################
require "libs/set"


proj = function ()

  local commands = {}
  local plugins = {}


  -- consistent coding style
  table.insert(plugins, "editorconfig/editorconfig-vim")


  return {
    commands = commands,
    plugins = plugins
  }
end
