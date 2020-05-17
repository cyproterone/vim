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

  require("nvim_lsp").jsonls.setup{}

end
ftp.defer(ft, lang)
