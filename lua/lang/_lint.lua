--#################### ########### ####################
--#################### Lint Region ####################
--#################### ########### ####################
local registry = require "libs/registry"
local lint = require "libs/lint"


local formats = function ()

  local t = lint.linter_type

  lint.add_linter("mypy", t.fs, {"%"})

end
registry.defer(formats)
