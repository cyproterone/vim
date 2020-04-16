require "libs/set"


whitespace = function ()

  local plugins = {}
  local defer = {}

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
    plugins = plugins,
    defer = defer,
  }
end
