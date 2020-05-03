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

  -- search buffer
  bindings.map.normal("s", [["zyiw:%s/<C-r>z//g<Left><Left>]])
  bindings.map.normal("S", [[:%s///g<Left><Left><Left>]])

end
registry.defer(hotkeys)


--#################### Search Region ####################

-- search without moving
registry.install("junegunn/vim-slash")
local improved_search = function ()

  -- centre on search result
  bindings.map.normal("<plug>(slash-after)", "zz")
  bindings.map.operator("<plug>(slash-after)", "zz")
  bindings.map.visual("<plug>(slash-after)", "zz")

end
registry.defer(improved_search)


--#################### FZF Region ####################

local fzf = function ()

  bindings.map.normal("<Leader>f", "g*N:BLines <C-r>/<CR>")
  bindings.map.normal("<Leader>F", "g*N:Rg <C-r>/<CR>")

end
registry.defer(fzf)


--#################### Replace Region ####################

-- registry.install("ms-jpq/sd.vim")
local sd = function ()


end
-- registry.defer(sd)
