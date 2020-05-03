local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

end
registry.defer(unmap_keys)


local map_keys = function ()

  -- dont go into ex mode
  bindings.map.command("<C-f>")

  -- use q to insert single char
  bindings.map.normal("q", "a🦄<Esc>r")
  bindings.map.normal("Q", "i🦄<Esc>r")

  -- use @ to do ^
  bindings.map.normal("@", "^")

end
registry.defer(map_keys)


-- fix cursor pos moving 1 back
local cursor_pos = function ()

  bindings.source(scripts_home .. "/cursor.vim")

end
registry.defer(cursor_pos)
