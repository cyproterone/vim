local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lsp")
local lsp_recommends = function ()

  bindings.set("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- go P
  bindings.map.normal("gp", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bindings.map.normal("gP", "<cmd>lua vim.lsp.buf.references()<CR>")

  -- go H
  bindings.map.normal("gh", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  bindings.map.normal("gH", "<cmd>lua vim.lsp.buf.implementation()<CR>")

  bindings.map.normal("K", "<cmd>lua vim.lsp.buf.hover()<CR>")

  -- go U
  bindings.map.normal("gu", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  bindings.map.normal("gU", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  -- go L
  bindings.map.normal("gl", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  bindings.map.normal("gL", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

end
registry.defer(lsp_recommends)
