local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

table.insert(plugins, { "neoclide/coc.nvim", branch = "release" })
local lsp = function ()

  bindings.source("lsp")

  bindings.set("cmdheight", 2)

  bindings.set("hidden")

  bindings.set("nobackup")
  bindings.set("nowritebackup")

  bindings.set("updatetime", 300)

  bindings.set("shortmess", "c", [[+=]])

end
table.insert(defer, lsp)


return {
  plugins = plugins,
  defer = defer,
}
