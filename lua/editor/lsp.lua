local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lsp")
local lsp_recommends = function ()

  bindings.set("omnifunc",     "v:lua.vim.lsp.omnifunc")
  bindings.set("completefunc", "v:lua.vim.lsp.omnifunc")

  bindings.map.normal("H", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
  bindings.map.normal("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  bindings.map.normal("L", "<cmd>lua vim.lsp.buf.rename()<CR>")
  bindings.map.normal("M", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  bindings.map.normal("gp", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bindings.map.normal("gP", "<cmd>lua vim.lsp.buf.references()<CR>")

  bindings.map.normal("gl", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  bindings.map.normal("gL", "<cmd>lua vim.lsp.buf.implementation()<CR>")

  bindings.map.normal("go", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  bindings.map.normal("gO", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  bindings.map.normal("ge", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  bindings.map.normal("gE", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

end
registry.defer(lsp_recommends)

