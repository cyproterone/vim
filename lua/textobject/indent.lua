
local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Text Object Region ####################

local inc = function (r) return r + 1 end
local dec = function (r) return r - 1 end


local line_at = function (row)
  return unpack(api.nvim_buf_get_lines(0, row, row + 1, true))
end


local indent_at = function (row)
  local line = line_at(row)
  return string.find(line, "%S") or 0
end


local p_accept_more = function (level)
  local seen = false
  return function (row)
    local lv = indent_at(row)
    local prev = seen
    seen = seen or lv > level
    return not prev
  end
end


local p_accept_next = function (level)
  return function (row)
    local lv = indent_at(row)
    return lv == 0 or lv >= level
  end
end


local seek = function (row, inc, accept)
  local min = 0
  local max = api.nvim_buf_line_count(0) - 1
  local acc = row
  while true do
    local nxt = inc(acc)
    if nxt < min or nxt > max then
      break
    end
    if accept(nxt) then
      acc = nxt
    else
      break
    end
  end
  return acc
end


local indent = function ()

  lv.textobj_indent = function ()
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    local level = indent_at(row)
    if level == 0 then
      local t = seek(row, inc, p_accept_more(level))
      local b = seek(row, dec, p_accept_more(level))
      level = math.max(indent_at(t),indent_at(b))
    end

    local top = seek(row, inc, p_accept_next(level))
    local btm = seek(row, dec, p_accept_next(level))

    fn.setpos("'<", {0, btm + 1, 1, 0})
    fn.setpos("'>", {0, top + 1, 1, 0})
    bindings.exec[[norm! `<V`>]]
  end

  bindings.map.operator("ii", "<cmd>lua lv.textobj_indent()<cr>")
  bindings.map.operator("ai", "<cmd>lua lv.textobj_indent()<cr>")
  bindings.map.visual("ii",   "<esc><cmd>lua lv.textobj_indent()<cr>")
  bindings.map.visual("ai",   "<esc><cmd>lua lv.textobj_indent()<cr>")

end
registry.defer(indent)
