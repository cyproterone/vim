local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Help Region ####################

registry.install("liuchengxu/vim-which-key")
local help = function ()

  bindings.map.normal("<Leader>", ":WhichKey '<Space>'<CR>")

  bindings.map.normal("[", "<cmd>WhichKey '['<CR>")
  bindings.map.normal("]", "<cmd>WhichKey ']'<CR>")

end
registry.defer(help)

