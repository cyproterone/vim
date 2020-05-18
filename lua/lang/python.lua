--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"python"}
local lang = function ()

  if not bindings.executable("dotnet") then
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

local always = function (buf)

  bindings.map.normal("gq", ":Neoformat autopep8<CR>", {buffer = buf})

end
ftp.always(ft, always)
