--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"json"}


local lsp = function ()
  if not bindings.executable("vscode-json-languageserver") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.jsonls.setup{}
  lsp.jsonls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
