local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Undo Region ####################

local undo_hist = function ()

  -- persistent undo
  bindings.set("undofile")

  -- maximum number of changes that can be undone
  bindings.set("undolevels", 1000)

  -- maximum number lines to save for undo on a buffer reload
  bindings.set("undoreload", 1000)

  -- bindings.map.normal("_", ":earlier ", {silent = false})
  -- bindings.map.normal("+", ":later ", {silent = false})

end
registry.defer(undo_hist)
