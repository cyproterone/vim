require "libs/set"


local plugins = {}
local defer = {}

--#################### Macros Region ####################

table.insert(plugins, "tpope/vim-repeat")

return {
  plugins = plugins,
  defer = defer,
}
