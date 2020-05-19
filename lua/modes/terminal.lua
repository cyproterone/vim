local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Terminal Region ####################

-- hotkeys
local hotkeys = function ()

  -- leave terminal
  bindings.map.terminal("<C-g>", [[<C-\><C-n>]])

end
registry.defer(hotkeys)


-- floating terminal
registry.install("voldikss/vim-floaterm")
local float_term = function ()

  -- close on exit code 0
  bindings.let("floaterm_autoclose", 1)
  -- size
  bindings.let("floaterm_width", 0.9)
  bindings.let("floaterm_height", 0.9)

  -- hotkeys
  bindings.map.normal("<Leader>u", ":FloatermToggle<CR>")
  bindings.map.normal("[z", ":FloatermPrev<CR>")
  bindings.map.normal("]z", ":FloatermNext<CR>")

end
registry.defer(float_term)
