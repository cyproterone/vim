--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"rust"}


local lsp = function ()
  if not bindings.executable("rust-analyzer") then
    return
  end
  local lsp = lv.lsp.rust_analyzer
  lsp.setup{
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("rustfmt", ft)
  lsp()
end
ftp.defer(ft, lang)
