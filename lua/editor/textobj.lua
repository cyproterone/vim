local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Text Object Region ####################

registry.install("kana/vim-textobj-user")
-- registry.install("kana/vim-textobj-entire")
registry.install("kana/vim-textobj-line")
registry.install("michaeljsmith/vim-indent-object")
registry.install("wellle/targets.vim")


local entire = function ()

  lv.textobj_entire = function ()
    local count = api.nvim_buf_line_count(0)
    local line = unpack(api.nvim_buf_get_lines(0, -2, -1, true))
    local len = string.len(line)
    fn.setpos("'[", {0, 1, 1, 0})
    fn.setpos("']", {0, count, len, 0})
    print(count, len)
  end

  bindings.map.operator("ae", "<cmd>lua lv.textobj_entire()<CR>", {silent=false})

end
registry.defer(entire)
