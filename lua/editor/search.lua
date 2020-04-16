require "libs/set"


search = function ()

  local commands = {}
  local plugins = {}

  --#################### Search Region ####################

  -- highlight search results
  table.insert(commands,
               bindings.set.id("hlsearch"))

  -- find result during search
  table.insert(commands,
               bindings.set.id("incsearch"))


  return {
    commands = commands,
    plugins = plugins
  }
end
