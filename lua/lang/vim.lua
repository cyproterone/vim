--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"vim"}


local lsp = function ()
  if not bindings.executable("vim-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.vimls.setup{}
  lsp.vimls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
