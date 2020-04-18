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
  bindings.map.normal("<Leader>l", ":nohlsearch<CR>")

end
table.insert(defer, hotkeys)


local regex = function ()

  -- use new regex engine
  bindings.set("regexpengine", 2)

end
table.insert(defer, regex)


--#################### Replace Region ####################

table.insert(plugins, "brooth/far.vim")
local search_replace = function ()

  -- enable undo
  bindings.let("far#enable_undo", true)

  -- use ripgrep
  -- bindings.let("far#source", "rgnvim")

  -- max results
  bindings.let("far#limit", 10000)

  -- find
  bindings.map.normal("<Leader>f", ":F ")

  -- replace
  bindings.map.normal("<Leader>r", ":Far ")

end
table.insert(defer, search_replace)


return {
  plugins = plugins,
  defer = defer,
}
