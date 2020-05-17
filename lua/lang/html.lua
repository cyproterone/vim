--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"html"}
local lang = function ()

  if not fn.executable("vscode-html-languageserver-bin") then
    return
  end

  require("nvim_lsp").html.setup{}

end
ftp.defer(ft, lang)
