local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  bindings.map.command("<C-q>", "<Esc>")

  -- emacs begining of line
  bindings.map.command("<C-a>", "<Home>")

  -- emacs end of line
  bindings.map.command("<C-e>", "<End>")

  -- enable paste
  bindings.map.command("<C-v>", [[<C-r>"]])

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
}
