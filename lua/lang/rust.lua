--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"rust"}


local lsp = function ()

  local lsp = require "nvim_lsp"
  lsp.rust_analyzer.setup{}
  lsp.rust_analyzer.manager.try_add()

  registry.const.omni("rust", {
    "\\w\\.\\w*",
    "\\w::\\w*"
  })
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
