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

  require("nvim_lsp").cssls.setup{}

end
ftp.defer(ft, lang)
