
local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Text Object Region ####################

local p_inner = function (line)
  local enil = string.reverse(line)
  local top = string.find(line, "%S") or 0
  local btm = #line - (string.find(enil, "%S") or 0) + 1
  return top, btm
end


local p_outer = function (line)
  return 1, #line
end


local line = function ()

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
