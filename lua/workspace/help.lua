local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Help Region ####################

registry.install("liuchengxu/vim-which-key")
local help = function ()

  bindings.map.normal("<Leader>", "<cmd>WhichKey '<Space>'<cr>")

  bindings.map.normal("[", "<cmd>WhichKey '['<cr>")
  bindings.map.normal("]", "<cmd>WhichKey ']'<cr>")

end
registry.defer(help)
