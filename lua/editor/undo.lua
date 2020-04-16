local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Undo Region ####################

local undo_hist = function ()

  -- set backup
  bindings.set("backup")
  
  -- persistent undo
  bindings.set("undofile")

  -- maximum number of changes that can be undone
  bindings.set("undolevels", 1000)

  -- maximum number lines to save for undo on a buffer reload
  bindings.set("undoreload", 1000)
  
end
table.insert(defer, undo_hist)


return {
  plugins = plugins,
  defer = defer,
}
