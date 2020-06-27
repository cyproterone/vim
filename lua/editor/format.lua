local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local registry = require "libs/registry"


--#################### Format Region ####################

local misc = function ()

  -- join only add 1 space
  bindings.set("nojoinspaces")

end
registry.defer(misc)


local sort = function ()

  lv.sort_lines = function (selec)
    local r1, _, r2, _ = bindings.p_op_marks(selec)
    -- vim has mixed indexing
    r1, r2 = r1 - 1, r2 - 1 + 1
    local lines = api.nvim_buf_get_lines(0, r1, r2, true)
    table.sort(lines, function (a, b)
      return vim.stricmp(a, b) < 0
    end)
    api.nvim_buf_set_lines(0, r1, r2, true, lines)
  end

  bindings.map.normal("gu", "<cmd>set opfunc=v:lua.lv.sort_lines<CR>g@")
  bindings.map.visual("gu", "<Esc><cmd>lua lv.sort_lines()<CR>")

end
registry.defer(sort)


local prettier = function ()

  lv.format = fmt.do_fmt

  -- remove default formatter
  bindings.map.normal("gq", "<cmd>lua lv.format()<CR>")
  bindings.map.normal("gQ", "<cmd>lua lv.format()<CR>")

end
registry.defer(prettier)
