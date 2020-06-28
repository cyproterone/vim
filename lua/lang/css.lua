--#################### ########## ####################
--#################### CSS Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"css", "scss", "less"}


local lsp = function ()
  if not bindings.executable("css-languageserver") then
    return
  end
  local lsp = require "nvim_lsp".cssls
  lsp.setup{
    root_dir = ftp.lsp_root,
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("prettier", ft)
  lsp()
end
ftp.defer(ft, lang)
