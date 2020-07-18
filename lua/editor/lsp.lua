local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lsp")
local lsp_recommends = function ()

  bindings.exec[[lua lv.lsp = require "nvim_lsp"]]

  bindings.set("omnifunc",     "v:lua.vim.lsp.omnifunc")

  bindings.map.normal("H", "<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>")
  bindings.map.normal("K", "<cmd>lua vim.lsp.buf.hover()<cr>")
  bindings.map.normal("R", "<cmd>lua vim.lsp.buf.rename()<cr>")
  bindings.map.normal("L", "<cmd>lua vim.lsp.buf.code_action()<cr>")

  bindings.map.normal("gp", "<cmd>lua vim.lsp.buf.definition()<cr>")
  bindings.map.normal("gP", "<cmd>lua vim.lsp.buf.references()<cr>")

  bindings.map.normal("gl", "<cmd>lua vim.lsp.buf.declaration()<cr>")
  bindings.map.normal("gL", "<cmd>lua vim.lsp.buf.implementation()<cr>")

  bindings.map.normal("go", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  bindings.map.normal("gO", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

  bindings.map.normal("ge", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
  bindings.map.normal("gE", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")

end
registry.defer(lsp_recommends)
