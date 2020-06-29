--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"go", "gomod"}


local lsp = function ()
  if not bindings.executable("gopls") then
    return
  end
  local lsp = require "nvim_lsp".gopls
  lsp.setup{
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("gofmt", ft)
  lsp()
end
ftp.defer(ft, lang)
