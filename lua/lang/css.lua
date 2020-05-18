--#################### ########## ####################
--#################### CSS Region ####################
--#################### ########## ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"css"}
local lang = function ()

  if not fn.executable("vscode-css-languageserver-bin") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.cssls.setup{}
  lsp.cssls.manager.try_add()

end
ftp.defer(ft, lang)
