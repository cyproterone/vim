--#################### ########### ####################
--#################### Lint Region ####################
--#################### ########### ####################
local registry = require "libs/registry"
local lint = require "libs/lint"


local formats = function ()

  local t = lint.linter_type

  lint.add_linter("mypy", t.fs, {"--", "%"})
  lint.add_linter("shellcheck", t.fs, {"--", "%"})
  lint.add_linter("sqlint", t.fs, {"--", "%"})

end
registry.defer(formats)
