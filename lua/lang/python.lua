--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"python"}


local format = function ()
  fmt.assoc_fmt("black", ft)
end


local lsp = function ()
  if not bindings.executable("pyls") then
    return
  end
  local lsp = require "nvim_lsp"
  lsp.pyls.setup{}
  lsp.pyls.manager.try_add()
end


local lang = function ()
  format()
  lsp()
end
ftp.defer(ft, lang)
