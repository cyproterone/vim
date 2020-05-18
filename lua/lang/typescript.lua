--#################### ################# ####################
--#################### Typescript Region ####################
--#################### ################# ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx" }


local format = function ()
  bindings.let("neoformat_enabled_javascript", {"prettier"})
  bindings.let("neoformat_enabled_typescript", {"prettier"})
end


local lsp = function ()
  if not bindings.executable("typescript-language-server") then
    return
  end

  local lsp = require "nvim_lsp"
  lsp.tsserver.setup{}
  lsp.tsserver.manager.try_add()

  for _, f in ipairs(ft) do
    registry.const.omni(f, {
      "\\w\\.\\w*",
    })
  end
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
