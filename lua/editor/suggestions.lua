local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- bindings.set("omnifunc")

end
table.insert(defer, suggestions)


return {
  plugins = plugins,
  defer = defer,
}
