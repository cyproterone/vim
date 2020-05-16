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

end
registry.defer(modern_search)


local hotkeys = function ()

  -- clear search result
  bindings.map.normal("<Leader>l", ":nohlsearch<CR>")

end
registry.defer(hotkeys)


local improved_search = function ()

  -- search without moving
  bindings.map.normal("*", "*N")
  bindings.map.normal("#", "*N")
  bindings.map.normal("g*", "g*N")
  bindings.map.normal("g#", "g*N")

  -- centre on search result
  bindings.map.normal("n", "nzz")
  bindings.map.normal("N", "Nzz")

end
registry.defer(improved_search)


-- use very magic
local magic = function ()

  bindings.map.nv("/", [[/\v]], {silent = false})
  bindings.map.nv("?", [[?\v]], {silent = false})

  -- search buffer
  bindings.map.normal("<Leader>r", [["zyiw:%s/\v<C-r>z//g<Left><Left>]], {silent = false})
  bindings.map.normal("<Leader>R", [[:%s/\v//g<Left><Left><Left>]], {silent = false})

end
registry.defer(magic)


local find = function ()

  local fd = function (_, ...)
    print(...)
  end
  registry.func("Go_find", fd)

  bindings.map.normal("gf", ":set opfunc=Go_find<CR>g@")

end
registry.defer(find)


--#################### Replace Region ####################

-- registry.install("ms-jpq/sd.vim")
local sd = function ()


end
-- registry.defer(sd)
