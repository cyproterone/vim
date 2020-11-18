--#################### ########### ####################
--#################### Lint Region ####################
--#################### ########### ####################
local registry = require "libs/registry"
local lint = require "libs/lint"


local formats = function ()

  local t = lint.linter_type

  lint.add_linter("mypy", t.fs, function ()
    return {"--", vim.fn.bufname("%")}
  end)

  lint.add_linter("shellcheck", t.fs, function ()
    return {"--", vim.fn.bufname("%")}
  end)

end
registry.defer(formats)
