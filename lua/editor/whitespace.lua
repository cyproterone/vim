local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Whitespace Region ####################

local tab_size = function ()

  -- how big are tabs ?
  bindings.set("tabstop", 2)

  -- spaces remove on deletion
  bindings.set("softtabstop", 2)

  -- manual indentation width
  bindings.set("shiftwidth", 2)

end
table.insert(defer, tab_size)


local unsurprising_tab = function ()

  -- insert spaces instead of tabs
  bindings.set("expandtab")

  -- smart indentation level
  bindings.set("autoindent")
  bindings.set("smarttab")

end
table.insert(defer, unsurprising_tab)


-- remove trailing whitespace
local trailing_whitespace = function ()

  bindings.auto{ group = "trim_whitespace",
                 events = "BufWritePre",
                 exec = [[:%s/\s\+$//e]] }

end
table.insert(defer, trailing_whitespace)


return {
  plugins = plugins,
  defer = defer,
}
