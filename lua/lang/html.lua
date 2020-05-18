--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"html"}
local lang = function ()

  if not bindings.executable("vscode-html-languageserver-bin") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.html.setup{}
  lsp.html.manager.try_add()

end
ftp.defer(ft, lang)
