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

  require("nvim_lsp").vimls.setup{}

end
ftp.defer(ft, lang)
