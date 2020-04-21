local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Help Region ####################

table.insert(plugins, "sunaku/vim-shortcut")
local help = function ()



end
table.insert(defer, help)


return {
  plugins = plugins,
  defer = defer,
}
