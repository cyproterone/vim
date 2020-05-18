local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Format Region ####################

-- prettiers
registry.install("sbdchd/neoformat")
local format = function ()

  -- remove default formatter
  bindings.map.normal("gq", ":Neoformat<CR>")
  bindings.map.normal("gQ", ":Neoformat<CR>")

end
registry.defer(format)

