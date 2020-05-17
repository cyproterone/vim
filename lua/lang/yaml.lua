--#################### ########### ####################
--#################### Yaml Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("yaml-language-server") then
    return
  end

  require("nvim_lsp").yamlls.setup{}

end
ftp.defer(lang)
