--#################### ############# ####################
--#################### Docker Region ####################
--#################### ############# ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"dockerfile"}
local lang = function ()

  if not bindings.executable("dockerfile-language-server-nodejs") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.dockerls.setup{}
  lsp.dockerls.manager.try_add()

end
ftp.defer(ft, lang)
