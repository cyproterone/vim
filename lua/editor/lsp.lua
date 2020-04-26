local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

table.insert(plugins, {"neoclide/coc.nvim", branch = "release"})
local lsp_recommends = function ()

  bindings.source(scripts_home .. "/lsp.vim")

  bindings.set("cmdheight", 2)

  bindings.set("nobackup")
  bindings.set("nowritebackup")

  bindings.set("updatetime", 300)

  bindings.set("shortmess", "c", [[+=]])

end
table.insert(defer, lsp_recommends)


return {
  plugins = plugins,
  defer = defer,
}
