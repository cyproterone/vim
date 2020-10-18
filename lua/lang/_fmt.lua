--#################### ############# ####################
--#################### Format Region ####################
--#################### ############# ####################
local registry = require "libs/registry"
local fmt = require "libs/fmt"


local formats = function ()

  local t = fmt.fmt_type

  fmt.add_fmt("fmt-json", t.stream, function ()
    return {vim.fn.bufname("%")}
  end)

  fmt.add_fmt("scfg", t.stream, function ()
    return {}
  end)

  fmt.add_fmt("prettier", t.stream, function ()
    return {"--stdin-filepath", "--", vim.fn.bufname("%")}
  end)

  fmt.add_fmt("fmt-py", t.stream, function ()
    return {}
  end)

  fmt.add_fmt("rustfmt", t.stream, function ()
    return {}
  end)

  fmt.add_fmt("gofmt", t.stream, function ()
    return {}
  end)

end
registry.defer(formats)
