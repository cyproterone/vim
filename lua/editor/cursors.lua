local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Cursors Region ####################

-- multi cursors
table.insert(plugins, "terryma/vim-multiple-cursors")


-- drag regions around
table.insert(plugins, "matze/vim-move")
-- default: M-j, M-k, M-h, M-l


-- auto parens
table.insert(plugins, "Raimondi/delimitMate")


-- easy quoting
table.insert(plugins, "tpope/vim-surround")


-- easy commenting
table.insert(plugins, "tpope/vim-commentary")


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
