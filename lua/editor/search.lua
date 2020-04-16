require "libs/set"


search = function ()

  local defer = {}
  local plugins = {}

  --#################### Search Region ####################

  -- highlight search results
  table.insert(
    defer,
    bindings.set.id("hlsearch"))

  -- find result during search
  table.insert(
    defer,
    bindings.set.id("incsearch"))


  return {
    defer = defer,
    plugins = plugins
  }
end
