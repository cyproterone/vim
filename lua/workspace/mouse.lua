local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Mouse Region ####################

-- enable mouse
local normal_mouse = function ()

  -- enable mouse in all modes
  bindings.set("mouse", "a")

  -- hide mouse when typing
  bindings.set("mousehide")

end
table.insert(defer, normal_mouse)


return {
  plugins = plugins,
  defer = defer,
}
