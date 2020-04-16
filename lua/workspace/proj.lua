local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Project Region ####################

-- consistent coding style
table.insert(plugins, "editorconfig/editorconfig-vim")


return {
  plugins = plugins,
  defer = defer,
}
