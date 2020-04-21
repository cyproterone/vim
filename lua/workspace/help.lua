local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Help Region ####################

local help = function ()

end
table.insert(defer, help)


return {
  plugins = plugins,
  defer = defer,
}
