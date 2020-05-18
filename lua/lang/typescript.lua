--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"typescript"}


local lsp = function ()
  if not bindings.executable("typescript-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.tsserver.setup{}
  lsp.tsserver.manager.try_add()

  registry.const.omni("typescript", {
    "\\w\\.\\w*",
  })
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
