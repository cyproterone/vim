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
    local len = string.len(line)
    local enil = string.reverse(line)
    local top = string.find(line, "%S")
    local btm = len - string.find(enil, "%S") + 1
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
      seen = seen or lv >= level
      return lv <= level or seen
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

  lv.textobj_indent = function ()
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    local level = indent_at(row)
    if level == 0 then
      local t = seek(row, inc, p_accept_more(level))
      local b = seek(row, dec, p_accept_more(level))
      level = math.max(t, b)
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
