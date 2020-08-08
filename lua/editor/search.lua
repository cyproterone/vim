local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Search Region ####################

local modern_search = function ()

  -- highlight search results
  bindings.set("hlsearch")

  -- find result during search
  bindings.set("incsearch")

  -- search results shown on side
  bindings.set("inccommand", "nosplit")

  -- use ripgrep
  bindings.set("grepprg", [[rg\ --vimgrep]])

end
registry.defer(modern_search)


local hotkeys = function ()

  -- clear search result
  bindings.map.normal("<leader>i", "<cmd>nohlsearch<cr>")

end
registry.defer(hotkeys)


local improved_search = function ()

  -- search without moving
  bindings.map.normal("*", "*Nzz")
  bindings.map.normal("#", "*Nzz")
  bindings.map.normal("g*", "g*Nzz")
  bindings.map.normal("g#", "g*Nzz")

  -- centre on search result
  bindings.map.normal("n", "nzz")
  bindings.map.normal("N", "Nzz")

end
registry.defer(improved_search)


-- use no magic
local nomagic = function ()

  bindings.map.nv("/", [[/\V]], {silent = false})
  bindings.map.nv("?", [[?\V]], {silent = false})

end
registry.defer(nomagic)
