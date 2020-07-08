--#################### ########### ####################
--#################### Bash Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local lint = require "libs/lint"
local ftp = require "libs/ftp"


local ft = {"sh", "zsh"}


local lsp = function ()
  if not bindings.executable("bash-language-server") then
    return
  end
  local lsp = lv.lsp.bashls
  lsp.setup{
    filetypes = {"sh", "zsh"},
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  lint.assoc_linter("shellcheck", ft)
  lsp()
end
ftp.defer(ft, lang)
