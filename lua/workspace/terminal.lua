local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Terminal Region ####################

local hotkeys = function ()

  -- leave terminal
  bindings.map.terminal("<C-g>", [[<C-\><C-n>]])

  -- enter terminal
  bindings.map.normal("<Leader>u", ":terminal<CR>")

end
registry.defer(hotkeys)
