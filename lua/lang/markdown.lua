--#################### ############### ####################
--#################### Markdown Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"markdown"}


local format = function ()
  vim.g.neoformat_enabled_markdown = {"prettier"}
end


local lang = function ()
  format()
end
ftp.defer(ft, lang)

