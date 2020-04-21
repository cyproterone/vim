local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Repl Region ####################

table.insert(plugins, "metakirby5/codi.vim")
local repl = function ()

end
table.insert(defer, repl)


return {
  plugins = plugins,
  defer = defer,
}
