local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Format Region ####################

-- align text
table.insert(plugins, "junegunn/vim-easy-align")


-- prettiers
table.insert(plugins, "sbdchd/neoformat")
local pretty = function ()

  -- disabled for performance reasons
  -- bindings.auto{events = "BufWritePre",
  --               exec = "undojoin | Neoformat"}

end
table.insert(defer, pretty)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
