local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Text Object Region ####################

table.insert(plugins, "kana/vim-textobj-user")
table.insert(plugins, "kana/vim-textobj-entire")
table.insert(plugins, "kana/vim-textobj-line")


return {
  plugins = plugins,
  defer = defer,
}

