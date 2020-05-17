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

  local fd_select = function (type)
    local norm = [["]]
    local reg = vim.fn.getreg(norm)
    local m = api.nvim_get_mode()
    if m.mode == "v" then
      bindings.exec[[exe "normal! gvy"]]
    elseif type == "line" then
      bindings.exec[[exe "normal! '[V']y"]]
    else
      bindings.exec[[exe "normal! `[v`]y"]]
    end
    local selec = vim.fn.getreg(norm)
    vim.fn.setreg(norm, reg)
    return selec
  end

  lua_fd = function (type)
    local selec = fd_select(type)
    print(selec)
    -- bindings.exec[[execute "normal! :BLines \<C-r>\""]]
  end

  bindings.map.normal("gf", ":set opfunc=v:lua.lua_fd<CR>g@")
  bindings.map.visual("gf", ":call v:lua.lua_fd()<CR>")

end
registry.defer(find)


--#################### Replace Region ####################

-- registry.install("ms-jpq/sd.vim")
local sd = function ()


end
-- registry.defer(sd)
