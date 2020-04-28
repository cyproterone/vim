local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

table.insert(plugins, {"neoclide/coc.nvim", branch = "release"})
local lsp_recommends = function ()

  bindings.source(scripts_home .. "/coc.vim")

  bindings.set("nobackup")
  bindings.set("nowritebackup")

  bindings.set("updatetime", 300)

end
table.insert(defer, lsp_recommends)


return {
  plugins = plugins,
  defer = defer,
}
