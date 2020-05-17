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

  require("nvim_lsp").tsserver.setup{}

  registry.const.omni("typescript", {
    "\\w\\.\\w*",
  })

end
ftp.defer(ft, lang)
