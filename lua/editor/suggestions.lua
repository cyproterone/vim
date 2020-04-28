local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 10)
  -- transparency
  bindings.set("pumblend", 20)

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- bindings.set("omnifunc")

end
table.insert(defer, suggestions)


return {
  plugins = plugins,
  defer = defer,
}
