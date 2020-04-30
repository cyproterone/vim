local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Insert Region ####################

-- add some emacs keys
local emacs_keys = function ()

  -- delete to end of line
  bindings.map.insert("<C-k>", "<C-o>D")

end
table.insert(defer, emacs_keys)


-- normal mode one keycord
local normal = function ()

  -- map c-space for completion
  bindings.map.insert("<C-space>", "<C-o>")
  bindings.map.normal("<C-space>")

end
table.insert(defer, normal)


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
  functions = functions,
}
