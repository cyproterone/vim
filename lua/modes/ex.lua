local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Ex Region ####################

-- disable exmode
local disable = function ()

  -- dont go into ex mode
  bindings.map.normal("Q", "<Nop>")
  bindings.map.normal("q:", "<Nop>")
  bindings.map.command("<C-f>", "<Nop>")

end
table.insert(defer, disable)


return {
  plugins = plugins,
  defer = defer,
}
