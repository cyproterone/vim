--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"cfg"}


local lang = function ()
  fmt.assoc_fmt("scfg", ft)
end
ftp.defer(ft, lang)
