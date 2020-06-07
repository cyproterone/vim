--#################### ########## ####################
--#################### XML Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"


local ft = {"xml"}


local format = function ()
  vim.g.neoformat_enabled_xml = {"prettier"}
end


local lang = function ()
  format()
end
ftp.defer(ft, lang)

