require "libs/set"


whitespace = function ()

  local commands = {}
  local plugins = {}

  --#################### Whitespace Region ####################

  -- insert spaces instead of tabs
  table.insert(commands,
               bindings.set.id("expandtab"))

  -- smart indentation level
  table.insert(commands,
               bindings.set.id("autoindent"))
  table.insert(commands,
               bindings.set.id("smarttab"))

  return {
    commands = commands,
    plugins = plugins
  }
end
