local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lsp")
local lsp_recommends = function ()


end
registry.defer(lsp_recommends)
