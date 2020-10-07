--#################### ######## ####################
--#################### R Region ####################
--#################### ######## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local lint = require "libs/lint"
local ftp = require "libs/ftp"


local ft = {"r", "rmd"}


local lsp = function ()
  if not bindings.executable("R") then
    return
  end
  local lsp = lv.lsp.r_language_server
  lsp.setup{
    root_dir = ftp.lsp_root{},
  }
  lsp.manager.try_add()
end


local lang = function ()
  lsp()
end
ftp.defer(ft, lang)
