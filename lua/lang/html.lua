--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"html"}


local format = function ()
  bindings.let("neoformat_enabled_html", {"prettier"})
end


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.html.setup{}
  lsp.html.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
