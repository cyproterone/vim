local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Navi Region ####################

-- use [ ] to navigate various lists, ie quickfix
local add_line = function ()

  lv.add_line = function (up)
    local count = math.max(vim.v.count, 1)
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    if up then
      local btm, top = math.max(row - 1, 0), row
      local lines = api.nvim_buf_get_lines(0, btm, top, true)
      for _ in std.range(1, count) do
        table.insert(lines, "")
      end
      api.nvim_buf_set_lines(0, btm, top, true, lines)
    else
      local max = api.nvim_buf_line_count(0)
      local btm, top = row + 1, math.min(row + 2, max)
      local lines = api.nvim_buf_get_lines(0, btm, top, true)
      local new_lines = {}
      for _ in std.range(1, count) do
        table.insert(new_lines, "")
      end
      for _, line in ipairs(lines) do
        table.insert(new_lines, line)
      end
      api.nvim_buf_set_lines(0, btm, top, true, new_lines)
    end
  end

  bindings.map.normal("[<space>", "<cmd>lua lv.add_line(true)<cr>")
  bindings.map.normal("]<space>", "<cmd>lua lv.add_line(false)<cr>")

end
registry.defer(add_line)
