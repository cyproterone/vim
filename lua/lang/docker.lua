--#################### ############# ####################
--#################### Docker Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"dockerfile"}


local lsp = function ()
  local lsp = require "nvim_lsp"
  lsp.dockerls.setup{}
  lsp.dockerls.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)

