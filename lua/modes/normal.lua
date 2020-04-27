local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

  -- unmap record
  bindings.map.normal("q")

end
table.insert(defer, unmap_keys)


local map_keys = function ()

  -- ; -> :
  bindings.map.normal(";", ":")

  -- show changes
  bindings.map.normal("<Leader>C", ":changes<CR>")

  -- select all
  bindings.map.normal("<Leader>v", "GVgg")

end
table.insert(defer, map_keys)


-- fix cursor pos moving 1 back
local cursor_pos = function ()

  bindings.source(scripts_home .. "/cursor.vim")

end
table.insert(defer, cursor_pos)

return {
  plugins = plugins,
  defer = defer,
}
