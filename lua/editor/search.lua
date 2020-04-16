require "libs/set"


search = function ()

  local plugins = {}
  local defer = {}

  --#################### Search Region ####################

  local modern_search = function ()
    -- highlight search results
    bindings.set("hlsearch")
    -- find result during search
    bindings.set("incsearch")
  end
  table.insert(defer, modern_search)


  return {
    plugins = plugins,
    defer = defer,
  }
end
