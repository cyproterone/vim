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


-- get selection
local p_marks = function (type)
  local m1, m2 = unpack(type and {"[", "]"} or {"<", ">"})
  local r1, c1 = unpack(api.nvim_buf_get_mark(0, m1))
  local r2, c2 = unpack(api.nvim_buf_get_mark(0, m2))
  return r1, c1, r2, c2
end


-- get selection
local p_selection = function (type)
  local r1, c1, r2, c2 = p_marks(type)
  -- vim has mixed indexing
  r1, r2 = r1 - 1, r2 - 1 + 1
  c1, c2 = c1 + 1, c2 + 1
  local lines = api.nvim_buf_get_lines(0, r1, r2, true)
  if r2 == r1 + 1 then
    lines[1] = string.sub(lines[1], c1, c2)
  else
    local last = r2 - r1
    lines[1] = string.sub(lines[1], c1)
    lines[last] = string.sub(lines[last], 1, c2)
  end
  return table.concat(lines, "\n")
end


local magic_escape = function (word)
  local escaped = fn.escape(word, [[/\]])
  return [[\V]] .. string.gsub(escaped, "\n", [[\n]])
end


-- find selection
local find = function ()

  local hlselect = function (text)
    fn.setreg("/", magic_escape(text))
    bindings.exec[[set hlsearch]]
  end

  lua_op_fzf = function (type)
    local selection = p_selection(type)
    hlselect(selection)
    bindings.exec("BLines " .. selection)
  end

  lua_op_rg = function (type)
    local selection = p_selection(type)
    hlselect(selection)
    bindings.exec("Rg " .. selection)
  end

  bindings.map.normal("gf", ":set opfunc=v:lua.lua_op_fzf<CR>g@")
  bindings.map.normal("gF", ":set opfunc=v:lua.lua_op_rg<CR>g@")

  bindings.map.visual("gf", "<Esc>:lua lua_op_fzf()<CR>")
  bindings.map.visual("gF", "<Esc>:lua lua_op_rg()<CR>")

end
registry.defer(find)


-- replace selection
local replace = function ()

  lua_op_sd = function (type)
    local selection = p_selection(type)
    local escaped = magic_escape(selection)
    -- no magic
    local input = [[:%s/]] .. escaped .. "//g<Left><Left>"
    api.nvim_input(input)
  end

  -- no magic
  bindings.map.normal("gt", ":set opfunc=v:lua.lua_op_sd<CR>g@")
  bindings.map.visual("gt", "<ESC>:lua lua_op_sd()<CR>")
  -- very magic
  bindings.map.normal("gT", [[:%s/\v//g<Left><Left><Left>]], {silent = false})

end
registry.defer(replace)

