local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 10)
  -- transparency
  bindings.set("pumblend", 10)

  -- dont show suggestions menu
  bindings.set("shortmess", "c", [[+=]])

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- complete menu
  bindings.set("completeopt", "menuone,noinsert", [[+=]])

end
table.insert(defer, suggestions)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
