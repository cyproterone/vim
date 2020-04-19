local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

local lsp = function ()

end
table.insert(defer, lsp)


return {
  plugins = plugins,
  defer = defer,
}
