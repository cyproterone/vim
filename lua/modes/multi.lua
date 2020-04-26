
local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Multi-Mode Region ####################

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

  -- paste before cursor
  bindings.map.normal("p", "P")
  bindings.map.visual("p", "P")

end
table.insert(defer, remap_keys)


return {
  plugins = plugins,
  defer = defer,
}
