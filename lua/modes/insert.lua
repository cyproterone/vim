local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Insert Region ####################

-- add a cursor cross in insert mode
local cursor_cross = function ()

  bindings.auto{group = "cursor_normal",
                events = "InsertEnter",
                exec = "set cursorcolumn"}

  bindings.auto{group = "cursor_cross",
                events = "InsertLeave",
                exec = "set nocursorcolumn"}

end
table.insert(defer, cursor_cross)


return {
  plugins = plugins,
  defer = defer,
}
