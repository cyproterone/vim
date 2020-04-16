require "libs/set"


highlight = function ()

  local commands = {}
  local plugins = {}

  --#################### Highlight Region ####################

  -- show line count
  table.insert(commands, bindings.set.id("number"))


  return {
    commands = commands,
    plugins = plugins
  }
end
