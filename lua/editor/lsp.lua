local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### LSP Region ####################

-- coc :TODO switch to native LSP at v0.5
table.insert(plugins, {"neoclide/coc.nvim", branch = "release" })
local lsp = function ()

  -- TODO: some lsp servers dont like these
  bindings.set("backup")
  bindings.set("nowritebackup")


  bindings.set("updatetime", 300)

  bindings.set("shortmess", "c", [[+=]])

  bindings.source("coc.vim")

end
table.insert(defer, lsp)


return {
  plugins = plugins,
  defer = defer,
}
