--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("dotnet") then
    return
  end

  require("nvim_lsp").pyls_ms.setup{}

  registry.const.omni("python", {
    "[^. *\\t]\\.\\w*"
  })

end
registry.defer(lang)
