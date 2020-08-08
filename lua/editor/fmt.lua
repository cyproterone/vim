local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local registry = require "libs/registry"


--#################### Format Region ####################

local misc = function ()

  -- join only add 1 space
  bindings.set("nojoinspaces")

end
registry.defer(misc)


local prettier = function ()

  lv.format = fmt.do_fmt

  -- run formatters
  bindings.map.normal("<leader>q", "<cmd>lua lv.format()<cr>")

end
registry.defer(prettier)
