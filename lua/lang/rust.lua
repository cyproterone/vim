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

  local lsp = require "nvim_lsp"
  lsp.rust_analyzer.setup{}
  lsp.rust_analyzer.manager.try_add()

  registry.const.omni("rust", {
    "\\w\\.\\w*",
    "\\w::\\w*"
  })

end
ftp.defer(ft, lang)
