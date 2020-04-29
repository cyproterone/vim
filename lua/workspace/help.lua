local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Help Region ####################

table.insert(plugins, "liuchengxu/vim-which-key")
local help = function ()

  bindings.map.normal("<Leader>", ":WhichKey '<Space>'<CR>")

  bindings.map.normal("[", ":WhichKey '['<CR>")
  bindings.map.normal("]", ":WhichKey ']'<CR>")

end
table.insert(defer, help)


return {
  plugins = plugins,
  defer = defer,
}
