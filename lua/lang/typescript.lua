--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx" }


local format = function ()
  vim.g.neoformat_enabled_javascript = {"prettier"}
  vim.g.neoformat_enabled_typescript = {"prettier"}
end


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.tsserver.setup{}
  lsp.tsserver.manager.try_add()

end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
