--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"html"}


local format = function ()
  vim.g.neoformat_enabled_html = {"prettier"}
end


local lsp = function ()
  if not bindings.executable("html-languageserver") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.html.setup{}
  lsp.html.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
