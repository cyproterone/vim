--#################### ########## ####################
--#################### XML Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local ftp = require "libs/ftp"
local registry = require "libs/registry"


local ft = {"xml"}


local format = function ()
  bindings.let("neoformat_enabled_xml", {"prettier"})
end


local lang = function ()
  format()
end
ftp.defer(ft, lang)
