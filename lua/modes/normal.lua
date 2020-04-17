local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Normal Region ####################

local keys = function ()

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
}
