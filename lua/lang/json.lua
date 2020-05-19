--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"json"}


local format = function ()
  bindings.let("neoformat_enabled_json", {"prettier"})
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
