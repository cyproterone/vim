--#################### ########### ####################
--#################### Bash Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("bash-language-server") then
    return
  end

  require("nvim_lsp").bashls.setup{filetypes = {"sh", "zsh"}}

end
registry.defer(lang)
