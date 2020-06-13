local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Paste Region ####################

local go_replace = function ()


  local split_newline = function (str)
    local new_lines = {}
    for line in vim.gsplit(str, "\n", true) do
      table.insert(new_lines, line)
    end
    return new_lines
  end

  lv.op_go_replace = function (selec)
    local r1, c1, r2, c2 = bindings.p_op_marks(selec)
    r1, r2 = r1 - 1, r2 - 1
    c1, c2 = c1 + 1, c2 + 1
    local text = fn.getreg("*")
    local lines = api.nvim_buf_get_lines(0, r1, r2 + 1, true)
    local lst = r2 - r1 + 1
    local pre = string.sub(lines[1], 1, c1 - 1)
    local post = string.sub(lines[lst], c2 + 1, string.len(lines[lst]))
    local replacement = pre .. text .. post
    local new_lines = split_newline(replacement)
    api.nvim_buf_set_lines(0, r1, r2 + 1, true, new_lines)
  end

  bindings.map.normal("gr", "<cmd>set opfunc=v:lua.lv.op_go_replace<CR>g@")
  bindings.map.visual("gr", "<Esc><cmd>lua lv.op_go_replace()<CR>")


  lv.op_go_replace_line = function ()
    local r, _ = unpack(api.nvim_win_get_cursor(0))
    r = r - 1
    local replacement = fn.getreg("*")
    local new_lines = split_newline(replacement)
    api.nvim_buf_set_lines(0, r, r + 1, true, new_lines)
  end

  bindings.map.normal("grr", "<cmd>lua lv.op_go_replace_line()<CR>")

end
registry.defer(go_replace)

