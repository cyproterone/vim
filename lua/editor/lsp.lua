local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lsp")
local lsp_recommends = function ()

  bindings.set("omnifunc", "v:lua.vim.lsp.omnifunc")

  bindings.map.normal("gd", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  bindings.map.normal("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")

  bindings.map.normal("K", "<cmd>lua vim.lsp.buf.hover()<CR>")

  bindings.map.normal("<Leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bindings.map.normal("<Leader>cD", "<cmd>lua vim.lsp.buf.references()<CR>")

  bindings.map.normal("<Leader>ck", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  bindings.map.normal("<Leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  bindings.map.normal("<Leader>cs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  bindings.map.normal("<Leader>cS", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

end
registry.defer(lsp_recommends)
