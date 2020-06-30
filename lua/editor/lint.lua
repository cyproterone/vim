local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Lint Region ####################

local lint =  function ()

  lv.lint = function () end

  -- run linter
  bindings.map.normal("gw", "<cmd>lua lv.lint()<cr>")
  bindings.map.visual("gw", "<esc><cmd>lua lv.lint()<cr>")
  bindings.map.normal("gwgw")
  bindings.map.normal("gww")

end
registry.defer(lint)
