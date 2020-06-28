--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"json"}


local lsp = function ()
  if not bindings.executable("vscode-json-languageserver") then
    return
  end
  local lsp = require "nvim_lsp".jsonls
  lsp.setup{
    root_dir = ftp.lsp_root,
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("fmt-json", ft)
  lsp()
end
ftp.defer(ft, lang)
