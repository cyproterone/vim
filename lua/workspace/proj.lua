--#################### ############## ####################
--#################### Project Region ####################
--#################### ############## ####################
require "libs/set"


navigation = function ()

  local commands = {}
  local plugins = {}


  -- consistent coding style
  table.insert(plugins, "editorconfig/editorconfig-vim")


  return {
    commands = commands,
    plugins = plugins
  }
end
