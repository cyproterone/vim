--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"lua"}


local lsp = function ()
  if not bindings.executable("lua-ls") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.sumneko_lua.setup{}
  lsp.sumneko_lua.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)

