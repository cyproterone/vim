require "libs/set"


whitespace = function ()

  local defer = {}
  local plugins = {}

  --#################### Whitespace Region ####################

  -- insert spaces instead of tabs
  table.insert(
    defer,
    bindings.set.id("expandtab"))

  -- smart indentation level
  table.insert(
    defer,
    bindings.set.id("autoindent"))
  table.insert(
    defer,
    bindings.set.id("smarttab"))

  return {
    defer = defer,
    plugins = plugins
  }
end
