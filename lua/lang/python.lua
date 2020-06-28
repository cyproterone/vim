--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"python"}


local lsp = function ()
  if not bindings.executable("pyls") then
    return
  end
  local lsp = require "nvim_lsp".pyls
  lsp.setup{
    root_dir = ftp.lsp_root,
    settings = {
      plugins = {
        pyls_mypy = {
          enabled = true,
          live_mode = true,
        }
      }
    },
  }
  lsp.manager.try_add()
end


local lang = function ()
  fmt.assoc_fmt("fmt-py", ft)
  lsp()
end
ftp.defer(ft, lang)
