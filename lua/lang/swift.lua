--#################### ############ ####################
--#################### Swift Region ####################
--#################### ############ ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local lint = require "libs/lint"
local ftp = require "libs/ftp"


local ft = {"swift", "c", "cpp", "objective-c", "objective-cpp"}


local lsp = function ()
  if not bindings.executable("xcrun") then
    return
  end
  local lsp = lv.lsp.sourcekit
  lsp.setup{
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
