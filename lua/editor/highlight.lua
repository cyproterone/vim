require "libs/set"


highlight = function ()

  local plugins = {}
  local defer = {}

  --#################### Highlight Region ####################

  -- syntax highlight
  table.insert(
    defer,
    bindings.arbitrary("filetype plugin indent on"))
  table.insert(
    defer,
    bindings.arbitrary("syntax on"))


  -- show line count
  table.insert(
    defer,
    bindings.set.id("number"))


  return {
    plugins = plugins,
    defer = defer,
  }
end
