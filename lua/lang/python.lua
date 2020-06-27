--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"python"}


local format = function ()
  vim.g.neoformat_python_autopep8 = {
    exe = "autopep8",
    args = {"-", "--indent-size=2"},
    stdin = 1}

  vim.g.neoformat_enabled_python = {"autopep8"}
end


local lsp = function ()
  if not bindings.executable("pyls") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.pyls.setup{}
  lsp.pyls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)

