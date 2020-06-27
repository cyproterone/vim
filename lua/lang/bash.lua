--#################### ########### ####################
--#################### Bash Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"sh", "zsh"}


local lsp = function ()
  if not bindings.executable("bash-language-server") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.bashls.setup{filetypes = {"sh", "zsh"}}
  lsp.bashls.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("shfmt", ft)
  lsp()
end
ftp.defer(ft, lang)
