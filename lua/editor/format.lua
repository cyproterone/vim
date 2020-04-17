local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Format Region ####################

-- align text
table.insert(plugins, "junegunn/vim-easy-align")


return {
  plugins = plugins,
  defer = defer,
}
