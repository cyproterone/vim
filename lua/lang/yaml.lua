--#################### ########### ####################
--#################### Yaml Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"yaml"}


local lsp = function ()
  if not bindings.executable("yaml-language-server") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.yamlls.setup{}
  lsp.yamlls.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("prettier", ft)
  lsp()
end
ftp.defer(ft, lang)
