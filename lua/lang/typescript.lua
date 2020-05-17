--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("typescript-language-server") then
    return
  end

  require("nvim_lsp").tsserver.setup{}

  registry.const.omni("typescript", {
    "\\w\\.\\w*",
  })

end
registry.defer(lang)

