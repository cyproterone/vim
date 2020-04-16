local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Navigation Region ####################

local wild = function ()
  -- ui for cmd auto complete
  bindings.set("wildmenu")

  -- auto complete menu
  bindings.set("wildmode", "longest,list,full")

  -- hide file history
  bindings.set("complete", "i", [[-=]])

  -- show command history
  bindings.set("showcmd")

  -- more history
  bindings.set("history", 10000)
end
table.insert(defer, wild)


return {
  plugins = plugins,
  defer = defer,
}
