--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"python"}


local format = function ()
  bindings.let("neoformat_python_autopep8", {
    exe = "autopep8",
    args = {"-", "--indent-size=2"},
    stdin = 1})

  bindings.let("neoformat_enabled_python", {"autopep8"})
end


local lsp = function ()
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


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
