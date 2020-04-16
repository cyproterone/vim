require "libs/set"


mouse = function ()

  local commands = {}
  local plugins = {}

  --#################### Mouse Region ####################

  -- enable mouse
  table.insert(commands, bindings.set.eq("mouse", "a"))


  return {
    commands = commands,
    plugins = plugins
  }
end
