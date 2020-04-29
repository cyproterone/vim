local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Visual Region ####################

-- more sensible keys
local keys = function ()

  -- keep selected when indenting
  bindings.map.visual("<", "<gv")
  bindings.map.visual(">", ">gv")

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}

