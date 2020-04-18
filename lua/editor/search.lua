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


--#################### Replace Region ####################

table.insert(plugins, "brooth/far.vim")
local search_replace = function ()

  -- enable undo
  bindings.let("far#enable_undo", true)

  -- use ripgrep TODO: fix this at v0.5
  -- bindings.let("far#source", "rgnvim")
  bindings.arbitrary [[
if has('python3')
  let g:far#source='rgnvim'
endif
]]

  -- find
  bindings.map.normal("<Leader>f", ":F ")

  -- replace
  bindings.map.normal("<Leader>r", ":Far ")


  -- performance!!
  bindings.let("far#auto_preview_on_start", false)
  -- max results
  bindings.let("far#limit", 100000)

end
table.insert(defer, search_replace)


return {
  plugins = plugins,
  defer = defer,
}
