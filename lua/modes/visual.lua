local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Visual Region ####################

local keys = function ()

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
}
