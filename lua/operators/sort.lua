local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local registry = require "libs/registry"


--#################### Format Region ####################

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

  bindings.map.normal("gu", "<cmd>set opfunc=v:lua.lv.sort_lines<cr>g@")
  bindings.map.visual("gu", "<esc><cmd>lua lv.sort_lines()<cr>")

end
registry.defer(sort)
