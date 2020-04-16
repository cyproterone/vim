--#################### ############### ####################
--#################### Keyboard Region ####################
--#################### ############### ####################
require "libs/set"


mouse = function ()

  local commands = {}
  local plugins = {}

  table.insert(commands, bindings.set.eq("mouse", "a"))


  return {
    commands = commands,
    plugins = plugins
  }
end
