local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

end
table.insert(defer, unmap_keys)


local map_keys = function ()

  -- show changes
  bindings.map.normal("<Leader>C", ":changes<CR>")

end
table.insert(defer, map_keys)

return {
  plugins = plugins,
  defer = defer,
}
