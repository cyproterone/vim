--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"vim"}
local lang = function ()

  if not bindings.executable("vim-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.vimls.setup{}
  lsp.vimls.manager.try_add()

end
ftp.defer(ft, lang)
