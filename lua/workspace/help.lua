local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Help Region ####################

table.insert(plugins, "liuchengxu/vim-which-key")
local help = function ()

  bindings.map.normal("<silent> <Leader>", ":WhichKey '<Space>'<CR>")

  bindings.map.normal("<silent> [", ":WhichKey '['<CR>")
  bindings.map.normal("<silent> ]", ":WhichKey ']'<CR>")

end
table.insert(defer, help)


return {
  plugins = plugins,
  defer = defer,
}
