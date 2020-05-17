--#################### ########### ####################
--#################### Rust Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local lang = function ()

  if not fn.executable("rust-analyzer") then
    return
  end

  require("nvim_lsp").rust_analyzer.setup{}

  registry.const.omni("rust", {
    "[^. *\\t]\\.\\w*",
    "\\w*::"
  })

end
registry.defer(lang)
