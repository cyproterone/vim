local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Mouse Region ####################

-- enable mouse
local normal_mouse = function ()

  -- enable mouse in all modes
  bindings.set("mouse", "a")

  -- right click behaviour
  bindings.set("mousemodel", "popup_setpos")

  -- doubleclick time
  bindings.set("mousetime", 250)

end
registry.defer(normal_mouse)
