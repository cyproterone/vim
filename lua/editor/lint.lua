local bindings = require "libs/bindings"
local lint = require "libs/lint"
local registry = require "libs/registry"


--#################### Lint Region ####################

local linter =  function ()

  lv.lint = lint.do_lint

  -- run linter
  bindings.map.normal("gw", "<cmd>lua lv.lint()<cr>")
  bindings.map.visual("gw", "<esc><cmd>lua lv.lint()<cr>")
  bindings.map.normal("gwgw")
  bindings.map.normal("gww")

end
registry.defer(linter)
