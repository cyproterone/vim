--#################### ############# ####################
--#################### Format Region ####################
--#################### ############# ####################
local registry = require "libs/registry"
local fmt = require "libs/fmt"


local formats = function ()

  fmt.add_fmt("prettier", true, {"--stdin-filepath", "%"})
  fmt.add_fmt("py-fmt", true, {})
  fmt.add_fmt("cargo", true, {"fmt"})

end
registry.defer(formats)
