local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Mouse Region ####################

-- enable mouse
local normal_mouse = function ()

  -- enable mouse in all modes
  bindings.set("mouse", "a")

end
registry.defer(normal_mouse)
