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

  bindings.map.operator("ie", "<cmd>lua lv.textobj_entire()<CR>")
  bindings.map.operator("ae", "<cmd>lua lv.textobj_entire()<CR>")
  bindings.map.visual("ie",   "<Esc><cmd>lua lv.textobj_entire()<CR>")
  bindings.map.visual("ae",   "<Esc><cmd>lua lv.textobj_entire()<CR>")

end
registry.defer(entire)


local line = function ()


  local p_inner = function (line)
    local len = string.len(line)
    local top, btm = 1, len
    for i in std.range(1, len) do
      if line[i] ~= " " then
        top = i
        break
      end
    end
    for i in std.range(len, 1, -1) do
      if line[i] ~= " " then
        btm = i
        break
      end
    end
    return top, btm
  end

  local p_outer = function (line)
    local len = string.len(line)
    return 1, len
  end

  lv.textobj_line = function (inner)
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    local line = unpack(api.nvim_buf_get_lines(0, row, row + 1, true))
    local top, btm = (inner and p_inner or p_outer)(line)
    fn.setpos("'<", {0, row + 1, top, 0})
    fn.setpos("'>", {0, row + 1, btm, 0})
    bindings.exec[[norm! gv]]
  end

  bindings.map.operator("il", "<cmd>lua lv.textobj_line(true)<CR>")
  bindings.map.operator("al", "<cmd>lua lv.textobj_line(false)<CR>")
  bindings.map.visual("il",   "<Esc><cmd>lua lv.textobj_line(true)<CR>")
  bindings.map.visual("al",   "<Esc><cmd>lua lv.textobj_line(false)<CR>")

end
registry.defer(line)
