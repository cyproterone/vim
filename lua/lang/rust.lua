--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"rust"}


local format = function ()
  fmt.assoc_fmt("cargo", ft)
end


local lsp = function ()
  if not bindings.executable("rust-analyzer") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.rust_analyzer.setup{}
  lsp.rust_analyzer.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
