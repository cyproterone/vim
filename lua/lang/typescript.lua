--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"typescript"}
local lang = function ()

  if not fn.executable("typescript-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.tsserver.setup{}
  lsp.tsserver.manager.try_add()

  registry.const.omni("typescript", {
    "\\w\\.\\w*",
  })

end
ftp.defer(ft, lang)
