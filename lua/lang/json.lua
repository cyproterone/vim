--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"json"}


local format = function ()
  vim.g.neoformat_enabled_json = {"prettier"}
end


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.jsonls.setup{}
  lsp.jsonls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)

