local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Unmap Region ####################

local unmap_keys = function ()

  -- dont go into ex mode
  bindings.map.normal("Q", "<Nop>")
  bindings.map.normal("q:", "<Nop>")
  bindings.map.command("<C-f>", "<Nop>")

end
table.insert(defer, unmap_keys)


return {
  plugins = plugins,
  defer = defer,
}
