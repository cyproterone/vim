local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Search Region ####################

local modern_search = function ()

  -- highlight search results
  bindings.set("hlsearch")

  -- find result during search
  bindings.set("incsearch")

  -- search results shown on side
  bindings.set("inccommand", "split")

end
table.insert(defer, modern_search)


local hotkeys = function ()

  -- clear search result
  bindings.map.normal("<Leader>l", ":nohlsearch<CR>")

end
table.insert(defer, hotkeys)


--#################### FZF Region ####################

local fzf = function ()

  bindings.map.normal("<Leader>f", "g*N:BLines <C-r>/<CR>")
  bindings.map.normal("<Leader>F", "g*N:Rg <C-r>/<CR>")

end
table.insert(defer, fzf)


--#################### Replace Region ####################

table.insert(plugins, "brooth/far.vim")
local search_replace = function ()

  -- enable undo
  bindings.let("far#enable_undo", true)


  -- performance!!
  bindings.let("far#auto_preview_on_start", false)
  -- max results
  bindings.let("far#limit", 100000)


  -- use ripgrep TODO: fix this at v0.5
  -- bindings.let("far#source", "rgnvim")
  bindings.arbitrary [[
if has('python3')
  let g:far#source='rgnvim'
endif
]]

  -- visual
  bindings.let("highlight_match", false)


  -- #################### Hotkeys Region ####################

  -- normal search
  bindings.map.normal("<Leader>R", ":Far ")

  -- search under cursor
  bindings.map.normal("<Leader>r", "g*N:Far <C-r>/ ")


end
table.insert(defer, search_replace)


return {
  plugins = plugins,
  defer = defer,
}
