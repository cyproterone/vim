--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"json"}
local lang = function ()

  if not fn.executable("vscode-json-languageserver") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.jsonls.setup{}
  lsp.jsonls.manager.try_add()

end
ftp.defer(ft, lang)
