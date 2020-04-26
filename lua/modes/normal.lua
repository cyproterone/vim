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

  -- reload config
  bindings.map.normal("<F5>", ":source $MYVIMRC<CR>")

  -- show changes
  bindings.map.normal("<Leader>C", ":changes<CR>")

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
