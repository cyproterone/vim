--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"python"}
local lang = function ()

  if not fn.executable("dotnet") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.pyls_ms.setup{}
  lsp.pyls_ms.manager.try_add()

  registry.const.omni("python", {
    "\\w\\.\\w*",
  })

end
ftp.defer(ft, lang)
