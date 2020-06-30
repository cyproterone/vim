local bindings = require "libs/bindings"
local lint = require "libs/lint"
local registry = require "libs/registry"


--#################### Lint Region ####################

local linter =  function ()

  lv.lint = lint.do_lint

  -- run linter
  bindings.map.normal("M", "<cmd>lua lv.lint()<cr>")

end
registry.defer(linter)
