--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx" }


local lsp = function ()
  if not bindings.executable("typescript-language-server") then
    return
  end
  local lsp = lv.lsp.tsserver
  lsp.setup{
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("prettier", ft)
  lsp()
end
ftp.defer(ft, lang)
