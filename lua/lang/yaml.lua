--#################### ########### ####################
--#################### Yaml Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"yaml"}
local lang = function ()

  if not bindings.executable("yaml-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.yamlls.setup{}
  lsp.yamlls.manager.try_add()

end
ftp.defer(ft, lang)
