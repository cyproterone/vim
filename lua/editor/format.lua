local bindings = require "libs/bindings"
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


-- prettiers
local prettier = function ()

  local fmt_stream = function ()
    local lines = vim.api
  end

  local fmt_fs = function ()
    bindings.exec[[checktime]]
  end

  lv.formatters = {}

  lv.format = function ()
    local ft = vim.bo.filetype
    local formatter = lv.formatters[ft]
  end

  -- remove default formatter
  bindings.map.normal("gq", "<cmd>lv.format()<CR>")
  bindings.map.normal("gQ", "<cmd>lv.format()<CR>")

end
registry.defer(prettier)
