--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("lua-language-server") then
    return
  end

  require("nvim_lsp").sumneko_lua.setup{}

end
registry.defer(lang)

