--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"html"}


local lsp = function ()
  if not bindings.executable("vscode-html-languageserver-bin") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.html.setup{}
  lsp.html.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
