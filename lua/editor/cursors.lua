local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Cursors Region ####################

-- expand selection
table.insert(plugins, "terryma/vim-expand-region")
-- "+" to grow ,"-" to shrink


-- multi cursors
table.insert(plugins, "terryma/vim-multiple-cursors")
local multi_cursor = function ()

  bindings.let("multi_cursor_use_default_mapping", false)
  bindings.let("multi_cursor_quit_key", "<ESC>")

  -- bindings.let("multi_cursor_prev_key", "")
  -- bindings.let("multi_cursor_prev_key", "")

end
table.insert(defer, multi_cursor)


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
}
