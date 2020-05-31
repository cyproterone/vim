--#################### ########### ####################
--#################### Yaml Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs.registry"


local ft = {"yaml"}
registry.install("stephpy/vim-yaml")


local format = function ()
  vim.g.neoformat_enabled_yaml = {"prettier"}
end


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.yamlls.setup{}
  lsp.yamlls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
