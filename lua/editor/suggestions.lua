local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Suggestions Region ####################

local suggestions = function ()

  -- bindings.set("omnifunc")

end
table.insert(defer, suggestions)


return {
  plugins = plugins,
  defer = defer,
}
