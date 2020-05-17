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

  require("nvim_lsp").pyls_ms.setup{}

  registry.const.omni("python", {
    "\\w\\.\\w*",
  })

end
ftp.defer(ft, lang)
