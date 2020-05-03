local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install({"neoclide/coc.nvim", branch = "release"})
local lsp_recommends = function ()

  bindings.source(scripts_home .. "/coc.vim")

  bindings.set("nobackup")
  bindings.set("nowritebackup")

end
registry.defer(lsp_recommends)
