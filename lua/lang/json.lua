--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("vscode-json-languageserver") then
    return
  end

  require("nvim_lsp").jsonls.setup{}

end
registry.defer(lang)
