local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Navi Region ####################

-- use [ ] to navigate various lists, ie quickfix
local unimpaired = function ()

  lv.add_line = function (up)
    local count = v:count or 1
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    if up then
      local btm, top = row - 1, row
      local lines = api.nvim_buf_get_lines(0, btm, top, false)
      for _ = 1, count do
        table.insert(lines, "")
      end
      api.nvim_buf_set_lines(0, btm, top, true, lines)
    else
      local btm, top = row + 1, row + 2
      local lines = api.nvim_buf_get_lines(0, btm, top, true)
      local new_lines = {}
      for _ in 1, count do
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
registry.defer(unimpaired)
