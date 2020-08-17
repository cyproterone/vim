--#################### ############# ####################
--#################### Python Region ####################
--#################### ############# ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"sql"}


-- local lsp = function ()
--   if not bindings.executable("pyls") then
--     return
--   end
--   local lsp = lv.lsp.pyls
--   lsp.setup{
--     root_dir = ftp.lsp_root{},
--   }
--   lsp.manager.try_add()
-- end


local lang = function ()
  fmt.assoc_fmt("sqlformat", ft)
  -- lsp()
end
ftp.defer(ft, lang)
