--#################### ########## ####################
--#################### CSS Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("vscode-css-languageserver-bin") then
    return
  end

  require("nvim_lsp").cssls.setup{}

end
registry.defer(lang)
