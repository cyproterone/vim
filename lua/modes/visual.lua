local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Visual Region ####################

-- more sensible keys
local keys = function ()

  -- dont shirt move too much
  bindings.map.visual("<s-up>",   "<up>")
  bindings.map.visual("<s-down>", "<down>")

end
registry.defer(keys)
