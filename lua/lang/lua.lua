--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"lua"}


local lsp = function ()
  if not bindings.executable("lua-ls") then
    return
  end
  local lsp = lv.lsp.sumneko_lua
  lsp.setup{
    cmd={"lua-ls"},
    root_dir = ftp.lsp_root{},
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT"
        },
        diagnostics = {
          disable = {"lowercase-global"},
        },
      },
    },
  }
  lsp.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
