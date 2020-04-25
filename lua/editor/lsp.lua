local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

table.insert(plugins, { "neoclide/coc.nvim", branch = "release" })
local lsp = function ()

  bindings.source("lsp")

end
table.insert(defer, lsp)


return {
  plugins = plugins,
  defer = defer,
}
