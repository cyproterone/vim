--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"rust"}
local lang = function ()

  if not fn.executable("rust-analyzer") then
    return
  end

  require("nvim_lsp").rust_analyzer.setup{}

  registry.const.omni("rust", {
    "\\w\\.\\w*",
    "\\w::\\w*"
  })

end
ftp.defer(ft, lang)
