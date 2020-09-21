--#################### ########## ####################
--#################### SQL Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local lint = require "libs/lint"
local ftp = require "libs/ftp"


local ft = {"sql"}


local lsp = function ()
  if not bindings.executable("sql-language-server") then
    return
  end
  local lsp = lv.lsp.sqlls
  lsp.setup{
    cmd = {"sql-language-server", "up", "--method", "stdio"},
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  lint.assoc_linter("sqlint", ft)
  lsp()
end
ftp.defer(ft, lang)
