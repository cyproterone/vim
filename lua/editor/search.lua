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

  local marked_text = function ()
    local r1, c1 = unpack(api.nvim_buf_get_mark(0, "["))
    local r2, c2 = unpack(api.nvim_buf_get_mark(0, "]"))
    local last_row = 1 + (r2 - r1)
    c1, c2 = c1 + 1, c2 + 1

    local lines = api.nvim_buf_get_lines(0, r1 - 1, r2, true)
    if r1 == r2 then
      lines[1] = string.sub(lines[1], c1, c2)
    else
      lines[1] = string.sub(lines[1], c1, string.len(lines[1]))
      lines[last_row] = string.sub(lines[last_row], 1, c2)
    endnvim_buf_get_marknvim_buf_get_mark

    return table.concat(lines, "\n")
  end

  lua_fd = function (type)
    local text = marked_text()
  end

  bindings.map.normal("gf", ":set opfunc=v:lua.lua_fd<CR>g@")
  bindings.map.visual("gf", ":call v:lua.lua_fd()")

end
registry.defer(find)


--#################### Replace Region ####################

-- registry.install("ms-jpq/sd.vim")
local sd = function ()


end
-- registry.defer(sd)
