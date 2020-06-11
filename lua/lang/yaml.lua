--#################### ########### ####################
--#################### Yaml Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"yaml"}


local format = function ()
  vim.g.neoformat_enabled_yaml = {"prettier"}
end


local lsp = function ()
  if not bindings.executable("yaml-language-server") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.yamlls.setup{}
  lsp.yamlls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)

