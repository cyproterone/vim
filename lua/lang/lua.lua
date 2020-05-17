--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("lua-language-server") then
    return
  end

  require("nvim_lsp").sumneko_lua.setup{}

  registry.const.omni("lua", {
    "\\w\\.\\w*",
  })

end
ftp.defer(lang)

