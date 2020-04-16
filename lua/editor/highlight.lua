require "libs/set"


highlight = function ()

  local commands = {}
  local plugins = {}

  --#################### Highlight Region ####################

  -- syntax highlight
  table.insert(commands,
               bindings.arbitrary("filetype plugin indent on"))
  table.insert(commands,
               bindings.arbitrary("syntax on"))


  -- show line count
  table.insert(commands,
               bindings.set.id("number"))


  return {
    commands = commands,
    plugins = plugins
  }
end
