local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  bindings.map.command("<C-q>", "<Esc>")

  -- enable paste
  bindings.map.command("<C-v>", [[<C-r>"]])

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
