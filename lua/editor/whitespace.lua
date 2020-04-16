local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Whitespace Region ####################

local unsurprising_tab = function ()
  -- insert spaces instead of tabs
  bindings.set("expandtab")

  -- smart indentation level
  bindings.set("autoindent")
  bindings.set("smarttab")
end
table.insert(defer, unsurprising_tab)


return {
  plugins = plugins,
  defer = defer,
}
