--#################### ########### ####################
--#################### Html Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("vscode-html-languageserver-bin") then
    return
  end

  require("nvim_lsp").html.setup{}

end
registry.defer(lang)

