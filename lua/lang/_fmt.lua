--#################### ############# ####################
--#################### Format Region ####################
--#################### ############# ####################
local registry = require "libs/registry"
local fmt = require "libs/fmt"


local formats = function ()

  fmt.add_fmt("prettier", true, {"--stdin-filepath", "%"})
  fmt.add_fmt("fmt-json", true, {"%"})
  fmt.add_fmt("fmt-py", true, {})
  fmt.add_fmt("rustfmt", true, {})

end
registry.defer(formats)
