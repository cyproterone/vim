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

  bindings.let("multi_cursor_use_default_mapping", 0)
  bindings.let("multi_cursor_quit_key", "<ESC>")

  -- bindings.let("multi_cursor_prev_key", "")
  -- bindings.let("multi_cursor_prev_key", "")

end
table.insert(defer, multi_cursor)


-- drag regions around
table.insert(plugins, "matze/vim-move")
-- default: M-j, M-k, M-h, M-l


-- easy quoting
table.insert(plugins, "tpope/vim-surround")


-- auto parens TODO: this thing is slow
--table.insert(plugins, "Raimondi/delimitMate")


return {
  plugins = plugins,
  defer = defer,
}
