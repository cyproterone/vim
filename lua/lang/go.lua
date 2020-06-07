--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"go", "gomod"}


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.gopls.setup{}
  lsp.gopls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)

