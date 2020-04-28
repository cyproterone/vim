local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Text Object Region ####################

-- expand text object selection
table.insert(plugins, "terryma/vim-expand-region")
-- "+" to grow ,"-" to shrink


table.insert(plugins, "kana/vim-textobj-user")
table.insert(plugins, "kana/vim-textobj-entire")
table.insert(plugins, "kana/vim-textobj-line")
table.insert(plugins, "michaeljsmith/vim-indent-object")


return {
  plugins = plugins,
  defer = defer,
}
