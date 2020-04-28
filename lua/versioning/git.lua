local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Git Region ####################

-- view git history
table.insert(plugins, "junegunn/gv.vim")


return {
  plugins = plugins,
  defer = defer,
}
