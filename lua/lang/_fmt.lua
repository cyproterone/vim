--#################### ############# ####################
--#################### Format Region ####################
--#################### ############# ####################
local registry = require "libs/registry"
local fmt = require "libs/fmt"


local formats = function ()

  local t = fmt.fmt_type

  fmt.add_fmt("fmt-json", t.stream, {"%"})
  fmt.add_fmt("fmt-py", t.stream, {})
  fmt.add_fmt("prettier", t.stream, {"--stdin-filepath", "%"})
  fmt.add_fmt("rustfmt", t.stream, {})
  fmt.add_fmt("gofmt", t.stream, {})
  fmt.add_fmt("scfg", t.stream, {})

end
registry.defer(formats)
