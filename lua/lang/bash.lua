--#################### ########### ####################
--#################### Bash Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"sh", "zsh"}
local lang = function ()

  if not bindings.executable("bash-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.bashls.setup{filetypes = {"sh", "zsh"}}
  lsp.bashls.manager.try_add()

end
ftp.defer(ft, lang)
