--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"vim"}
local lang = function ()

  if not fn.executable("vim-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.vimls.setup{}
  lsp.vimls.manager.try_add()

end
ftp.defer(ft, lang)
