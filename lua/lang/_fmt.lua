--#################### ############# ####################
--#################### Format Region ####################
--#################### ############# ####################
local registry = require "libs/registry"
local fmt = require "libs/fmt"


local formats = function ()

  fmt.add_fmt("prettier", true, {})
  fmt.add_fmt("py-fmt", true, {})

end
registry.defer(formats)
