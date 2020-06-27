local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Text Object Region ####################

registry.install("michaeljsmith/vim-indent-object")
registry.install("wellle/targets.vim")


local entire = function ()

  lv.textobj_entire = function ()
    local count = api.nvim_buf_line_count(0)
    local line = unpack(api.nvim_buf_get_lines(0, -2, -1, true))
    local len = string.len(line)
    fn.setpos("'<", {0, 1, 1, 0})
    fn.setpos("'>", {0, count, len, 0})
    bindings.exec[[norm! gv]]
  end

  bindings.map.operator("ie", "<cmd>lua lv.textobj_entire()<cr>")
  bindings.map.operator("ae", "<cmd>lua lv.textobj_entire()<cr>")
  bindings.map.visual("ie",   "<esc><cmd>lua lv.textobj_entire()<cr>")
  bindings.map.visual("ae",   "<esc><cmd>lua lv.textobj_entire()<cr>")

end
registry.defer(entire)


local line = function ()

  local p_inner = function (line)
    local enil = string.reverse(line)
    local top = string.find(line, "%S")
    local btm = string.len(line) - string.find(enil, "%S") + 1
    return top, btm
  end

  local p_outer = function (line)
    local len = string.len(line)
    return 1, len
  end

  lv.textobj_line = function (inner)
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    local line = api.nvim_get_current_line()
    local top, btm = (inner and p_inner or p_outer)(line)
    fn.setpos("'<", {0, row, top, 0})
    fn.setpos("'>", {0, row, btm, 0})
    bindings.exec[[norm! gv]]
  end

  bindings.map.operator("il", "<cmd>lua lv.textobj_line(true)<cr>")
  bindings.map.operator("al", "<cmd>lua lv.textobj_line(false)<cr>")
  bindings.map.visual("il",   "<esc><cmd>lua lv.textobj_line(true)<cr>")
  bindings.map.visual("al",   "<esc><cmd>lua lv.textobj_line(false)<cr>")

end
registry.defer(line)


local indent = function ()

  local p_indent = function (line)
    return string.find(line, "%S") - 1
  end

  local p_accept = function (level, line)
    local lv = p_indent(line)
    return lv == nil or lv >= level
  end

  lv.textobj_indent = function ()
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    local line = api.nvim_get_current_line()
    local level = p_indent(line)

    local top, btm = row, row
    while true do
      break
    end
    while true do
      break
    end

  end

end
registry.defer(indent)
