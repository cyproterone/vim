--#################### ########### ####################
--#################### JSON Region ####################
--#################### ########### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"json"}


local lang = function ()
  fmt.assoc_fmt("fmt-json", ft)
end
ftp.defer(ft, lang)
