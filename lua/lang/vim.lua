--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("vim-language-server") then
    return
  end

  require("nvim_lsp").vimls.setup{}

end
registry.defer(lang)


