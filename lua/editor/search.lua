local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Search Region ####################

local modern_search = function ()

  -- highlight search results
  bindings.set("hlsearch")

  -- find result during search
  bindings.set("incsearch")

  -- search results shown on side
  bindings.set("inccommand", "nosplit")

end
table.insert(defer, modern_search)


local hotkeys = function ()

  -- clear search result
  bindings.map.normal("<Leader>l", ":nohlsearch<CR>")

end
table.insert(defer, hotkeys)


--#################### Search Region ####################

-- search without moving
table.insert(plugins, "junegunn/vim-slash")
local improved_search = function ()

  -- centre on search result
  bindings.map.normal("<plug>(slash-after)", "zz")
  bindings.map.operator("<plug>(slash-after)", "zz")
  bindings.map.visual("<plug>(slash-after)", "zz")

end
table.insert(defer, improved_search)


--#################### FZF Region ####################

local fzf = function ()

  bindings.map.normal("<Leader>f", "g*N:BLines <C-r>/<CR>")
  bindings.map.normal("<Leader>F", "g*N:Rg <C-r>/<CR>")

end
table.insert(defer, fzf)


--#################### Replace Region ####################

-- table.insert(plugins, "ms-jpq/sd.vim")
local sd = function ()

end
table.insert(defer, sd)

return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
