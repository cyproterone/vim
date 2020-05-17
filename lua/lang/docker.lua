--#################### ############# ####################
--#################### Docker Region ####################
--#################### ############# ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"dockerfile"}
local lang = function ()

  if not fn.executable("dockerfile-language-server-nodejs") then
    return
  end

  require("nvim_lsp").dockerls.setup{}

end
ftp.defer(ft, lang)
