--#################### ########### ####################
--#################### Bash Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"sh", "zsh"}


local lsp = function ()

  local lsp = require "nvim_lsp"
  lsp.bashls.setup{filetypes = {"sh", "zsh"}}
  lsp.bashls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
