local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Text Object Region ####################

registry.install("wellle/targets.vim")


local entire = function ()

  lv.textobj_entire = function ()
    local count = api.nvim_buf_line_count(0)
    local line = unpack(api.nvim_buf_get_lines(0, -2, -1, true))
    local len = string.len(line)
    fn.setpos("'<", {0, 1, 1, 0})
    fn.setpos("'>", {0, count, len, 0})
    bindings.exec[[norm! `<V`>]]
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
    bindings.exec[[norm! `<v`>]]
  end

  bindings.map.operator("il", "<cmd>lua lv.textobj_line(true)<cr>")
  bindings.map.operator("al", "<cmd>lua lv.textobj_line(false)<cr>")
  bindings.map.visual("il",   "<esc><cmd>lua lv.textobj_line(true)<cr>")
  bindings.map.visual("al",   "<esc><cmd>lua lv.textobj_line(false)<cr>")

end
registry.defer(line)


local indent = function ()

  local p_indent = function (line)
    return string.find(line, "%S")
  end

  local p_accept = function (level, line)
    local lv = p_indent(line)
    return lv == nil or lv >= level
  end

  local line_at = function (row)
    return unpack(api.nvim_buf_get_lines(0, row, row + 1, true))
  end

  local seek = function (row, level, inc)
    local acc = row
    while true do
      local nxt = inc(acc)
      local line = line_at(nxt)
      if p_accept(level, line) then
        acc = nxt
      else
        break
      end
    end
    return acc
  end

  lv.textobj_indent = function ()
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    local line = api.nvim_get_current_line()
    local level = p_indent(line)

    local top = seek(row, level, function (r) return r + 1 end)
    local btm = seek(row, level, function (r) return r - 1 end)
    local top_line = line_at(top)
    local top_len = string.len(top_line)
    fn.setpos("'<", {0, btm + 1, 1, 0})
    fn.setpos("'>", {0, top + 1, top_len, 0})
    bindings.exec[[norm! `<V`>]]
  end

  bindings.map.operator("ii", "<cmd>lua lv.textobj_indent()<cr>")
  bindings.map.operator("ai", "<cmd>lua lv.textobj_indent()<cr>")
  bindings.map.visual("ii",   "<esc><cmd>lua lv.textobj_indent()<cr>")
  bindings.map.visual("ai",   "<esc><cmd>lua lv.textobj_indent()<cr>")

end
registry.defer(indent)
