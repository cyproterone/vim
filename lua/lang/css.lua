--#################### ########## ####################
--#################### CSS Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"css", "scss", "less"}


local format = function ()
  bindings.let("neoformat_enabled_css", {"prettier"})
end


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.cssls.setup{}
  lsp.cssls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
