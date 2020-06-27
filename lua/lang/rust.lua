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
  local lsp = require "nvim_lsp"
  lsp.rust_analyzer.setup{}
  lsp.rust_analyzer.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("rustfmt", ft)
  lsp()
end
ftp.defer(ft, lang)
