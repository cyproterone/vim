--#################### ################ ####################
--#################### Highlight Region ####################
--#################### ################ ####################
require "libs/set"


highlight = function ()

  local commands = {
    bindings.set.eq("numbers", 1)
  }


  local plugins = {}


  return {
    commands = commands,
    plugins = plugins
  }
end
