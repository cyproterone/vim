local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Project Region ####################

-- consistent coding style
table.insert(plugins, "editorconfig/editorconfig-vim")


return {
  plugins = plugins,
  defer = defer,
}
