local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Text Object Region ####################

local entire = function ()

  lv.textobj_entire = function ()
    local count = api.nvim_buf_line_count(0)
    local line = unpack(api.nvim_buf_get_lines(0, -2, -1, true))
    fn.setpos("'<", {0, 1, 1, 0})
    fn.setpos("'>", {0, count, #line, 0})
    bindings.exec[[norm! `<V`>]]
  end

  bindings.map.operator("ie", "<cmd>lua lv.textobj_entire()<cr>")
  bindings.map.operator("ae", "<cmd>lua lv.textobj_entire()<cr>")
  bindings.map.visual("ie",   "<esc><cmd>lua lv.textobj_entire()<cr>")
  bindings.map.visual("ae",   "<esc><cmd>lua lv.textobj_entire()<cr>")

end
registry.defer(entire)
