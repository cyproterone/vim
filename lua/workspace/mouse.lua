--#################### ############### ####################
--#################### Keyboard Region ####################
--#################### ############### ####################
require "libs/set"


mouse = function ()

  local commands = {
    bindings.set.eq("mouse", "a")
  }

  local plugins = {}


  return {
    commands = commands,
    plugins = plugins
  }
end
