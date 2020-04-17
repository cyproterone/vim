local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

end
table.insert(defer, unmap_keys)


return {
  plugins = plugins,
  defer = defer,
}
