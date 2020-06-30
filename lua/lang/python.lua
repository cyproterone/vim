--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local lint = require "libs/lint"
local ftp = require "libs/ftp"


local ft = {"python"}


local lsp = function ()
  if not bindings.executable("pyls") then
    return
  end
  local lsp = require "nvim_lsp".pyls
  lsp.setup{
    root_dir = ftp.lsp_root{},
    settings = {
      plugins = {
        pyls_mypy = {
          enabled = true,
        }
      }
    },
  }
  lsp.manager.try_add()
end


local lang = function ()
  lint.assoc_linter("mypy", ft)
  fmt.assoc_fmt("fmt-py", ft)
  lsp()
end
ftp.defer(ft, lang)
