--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  require("nvim_lsp").pyls_ms.setup{}

end
registry.defer(lang)
