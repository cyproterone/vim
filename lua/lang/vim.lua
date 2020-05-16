--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  require("nvim_lsp").vimls.setup{}

end
registry.defer(lang)


