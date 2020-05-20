local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Format Region ####################

local sort = function ()

  local p_marks = function (type)
    local m1, m2 = unpack(type and {"[", "]"} or {"<", ">"})
    local r1, c1 = unpack(api.nvim_buf_get_mark(0, m1))
    local r2, c2 = unpack(api.nvim_buf_get_mark(0, m2))
    return r1, c1, r2, c2
  end

  lua_sort_lines = function (type)
    local r1, _, r2, _ = p_marks(type)
    -- vim has mixed indexing
    r1, r2 = r1 - 1, r2 - 1 + 1
    local lines = api.nvim_buf_get_lines(0, r1, r2, true)
    table.sort(lines, function (a, b)
      return vim.stricmp(a, b) < 0
    end)
    api.nvim_buf_set_lines(0, r1, r2, true, lines)
  end

  bindings.map.normal("gs", ":set opfunc=v:lua.lua_sort_lines<CR>g@")
  bindings.map.visual("gs", "<Esc>:lua lua_sort_lines()<CR>")

end
registry.defer(sort)


-- prettiers
registry.install("sbdchd/neoformat")
local prettier = function ()

  -- remove default formatter
  bindings.map.normal("gq", ":Neoformat<CR>")
  bindings.map.normal("gQ", ":Neoformat<CR>")

end
registry.defer(prettier)

