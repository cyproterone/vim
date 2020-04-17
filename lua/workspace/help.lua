local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Help Region ####################

local help_keys = function ()

  bindings.map.normal("<leader>h", ":help ")

end
table.insert(defer, help_keys)


return {
  plugins = plugins,
  defer = defer,
}
