local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

end
table.insert(defer, unmap_keys)


local remap_keys = function ()

  -- delete dont copy
  bindings.map.normal("d", [["_d]])
  bindings.map.normal("D", [["_D]])

  bindings.map.normal("x", [["_x]])
  bindings.map.normal("X", [["_X]])

  bindings.map.visual("d", [["_d]])
  bindings.map.visual("D", [["_D]])

  bindings.map.visual("x", [["_x]])
  bindings.map.visual("X", [["_X]])

end
table.insert(defer, remap_keys)


return {
  plugins = plugins,
  defer = defer,
}
