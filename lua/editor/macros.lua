local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Macros Region ####################

table.insert(plugins, "tpope/vim-repeat")

return {
  plugins = plugins,
  defer = defer,
}
