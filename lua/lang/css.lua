--#################### ########## ####################
--#################### CSS Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"css"}


local lsp = function ()
  if not bindings.executable("vscode-css-languageserver-bin") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.cssls.setup{}
  lsp.cssls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
