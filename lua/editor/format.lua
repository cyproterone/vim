local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Format Region ####################

-- align text
table.insert(plugins, "junegunn/vim-easy-align")


-- prettiers
table.insert(plugins, "sbdchd/neoformat")
local pretty = function ()

  bindings.auto{ group = "formatting",
                 events = { "BufWritePre" },
                 exec = "undojoin | Neoformat" }

end
table.insert(defer, pretty)


return {
  plugins = plugins,
  defer = defer,
}
