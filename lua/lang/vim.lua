--#################### ############### ####################
--#################### Vim Lang Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"vim"}


local lsp = function ()
  if not bindings.executable("vim-language-server") then
    return
  end
  local lsp = require "nvim_lsp".vimls
  lsp.setup{
    root_dir = ftp.lsp_root,
  }
  lsp.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
