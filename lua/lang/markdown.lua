--#################### ############### ####################
--#################### Markdown Region ####################
--#################### ############### ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local ft = {"markdown"}


local lang = function ()
  fmt.assoc_fmt("prettier", ft)
end
ftp.defer(ft, lang)
