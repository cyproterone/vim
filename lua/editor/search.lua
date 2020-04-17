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


--#################### Replace Region ####################

table.insert(plugins, "brooth/far.vim")
local search_replace = function ()

  -- find single file
  bindings.map.normal("<Leader>ff", ":F")

  -- replace single file
  bindings.map.normal("<Leader>fr", ":Far")


  -- find multiple file
  bindings.map.normal("<Leader>rf", ":F")

  -- replace multiple file
  bindings.map.normal("<Leader>rr", ":Far")


end
table.insert(defer, search_replace)


return {
  plugins = plugins,
  defer = defer,
}
