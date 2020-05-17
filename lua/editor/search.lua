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


-- get selection
local fd_select = function (type)
  if type == "line" then
    bindings.exec[[exe "norm! '[V']\"zy"]]
  else
    bindings.exec[[exe "norm! `[v`]\"zy"]]
  end
end


-- use very magic
local magic = function ()

  bindings.map.nv("/", [[/\v]], {silent = false})
  bindings.map.nv("?", [[?\v]], {silent = false})

end
registry.defer(magic)


-- find selection
local find = function ()

  lua_op_fzf = function (type)
    fd_select(type)
    bindings.exec[[exe "norm! :BLines \<C-r>z\<CR>"]]
  end

  lua_op_rg = function (type)
    fd_select(type)
    bindings.exec[[exe "norm! :Rg \<C-r>z\<CR>"]]
  end

  bindings.map.normal("gf", ":set opfunc=v:lua.lua_op_fzf<CR>g@")
  bindings.map.normal("gF", ":set opfunc=v:lua.lua_op_rg<CR>g@")

  bindings.map.visual("gf", [["zy:BLines <C-r>z<CR>]])
  bindings.map.visual("gF", [["zy:Rg <C-r>z<CR>]])

end
registry.defer(find)


-- replace selection
local replace = function ()

  lua_op_sd = function (type)
    fd_select(type)
    api.nvim_input([[:%s/\v<C-r>z//g<Left><Left>]])
  end

  -- search buffer
  bindings.map.normal("gt", ":set opfunc=v:lua.lua_op_sd<CR>g@")
  bindings.map.normal("gT", [[:%s/\v//g<Left><Left><Left>]], {silent = false})

end
registry.defer(replace)

