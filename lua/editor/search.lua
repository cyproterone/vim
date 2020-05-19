local bindings = require "libs/bindings"
  bindings.map.visual("gf", [["zy:lua lua_op_fzf()<CR>]])
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

  -- clear quickfix
  bindings.map.normal("<Leader>L", ":cclose<CR>")

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


-- hi select
local hlselect = function ()
  fn.setreg("/", "\\V" .. fn.getreg("z"))
  bindings.exec[[set hlsearch]]
end


-- get selection
local fd_select = function (type)
  if type == "line" then
    bindings.exec[[exe "norm! '[V']\"zy"]]
  else
    bindings.exec[[exe "norm! `[v`]\"zy"]]
  end
end


-- find selection
local find = function ()

  lua_op_fzf = function (type)
    local _ = type and fd_select(type)
    hlselect()
    bindings.exec[[exe "norm! :BLines \<C-r>z\<CR>"]]
  end

  lua_op_rg = function (type)
    local _ = type and fd_select(type)
    hlselect()
    bindings.exec[[exe "norm! :Rg \<C-r>z\<CR>"]]
  end

  bindings.map.normal("gf", ":set opfunc=v:lua.lua_op_fzf<CR>g@")
  bindings.map.normal("gF", ":set opfunc=v:lua.lua_op_rg<CR>g@")

  bindings.map.visual("gf", [["zy:lua lua_op_fzf()<CR>]])
  bindings.map.visual("gF", [["zy:lua lua_op_rg()<CR>]])

end
registry.defer(find)


-- replace selection
local replace = function ()

  lua_op_sd = function (type)
    fd_select(type)
    -- no magic
    api.nvim_input[[:%s/\V<C-r>z//g<Left><Left>]]
  end

  -- no magic
  bindings.map.normal("gt", ":set opfunc=v:lua.lua_op_sd<CR>g@")

  -- very magic
  bindings.map.normal("gT", [[:%s/\v//g<Left><Left><Left>]], {silent = false})

end
registry.defer(replace)

