require "libs/set"


search = function ()

  local plugins = {}
  local defer = {}

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
    plugins = plugins,
    defer = defer,
  }
end
