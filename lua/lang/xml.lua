--#################### ########## ####################
--#################### XML Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"xml"}


local format = function ()
  fmt.assoc_fmt("prettier", ft)
end


local lang = function ()
  format()
end
ftp.defer(ft, lang)
