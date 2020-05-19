--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"lua"}


local lsp = function ()

  local lsp = require "nvim_lsp"
  lsp.sumneko_lua.setup{}
  lsp.sumneko_lua.manager.try_add()

  registry.const.omni("lua", {
    "\\w\\.\\w*",
  })
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
