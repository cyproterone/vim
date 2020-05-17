--#################### ############# ####################
--#################### Docker Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("dockerfile-language-server-nodejs") then
    return
  end

  require("nvim_lsp").dockerls.setup{}

end
registry.defer(lang)
