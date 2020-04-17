local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Search Region ####################

local modern_search = function ()

  -- highlight search results
  bindings.set("hlsearch")

  -- find result during search
  bindings.set("incsearch")

end
table.insert(defer, modern_search)


local hotkeys = function ()

  -- clear search result
  bindings.map.normal("C-l", ":nohlsearch<CR>")

end
table.insert(defer, hotkeys)


return {
  plugins = plugins,
  defer = defer,
}
