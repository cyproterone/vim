--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"lua"}
local lang = function ()

  if not bindings.executable("lua-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.sumneko_lua.setup{}
  lsp.sumneko_lua.manager.try_add()

  registry.const.omni("lua", {
    "\\w\\.\\w*",
  })

end
ftp.defer(ft, lang)
