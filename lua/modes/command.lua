local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  bindings.map.command("<C-a>", "<Home>")

end
table.insert(defer, keys)


return {
  plugins = plugins,
  defer = defer,
}
