local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Paste Region ####################


local go_replace = function ()

  lv.op_go_replace = function (selec)
    local r1, c1, r2, c2 = bindings.p_op_marks(selec)

  end

  bindings.map.normal("gr", "<cmd>set opfunc=v:lua.lv.op_go_replace<CR>g@")
  bindings.map.visual("gr", "<Esc><cmd>lua lv.op_go_replace()<CR>")

end
registry.defer(go_replace)


-- gr :: go replace
-- registry.install("inkarkat/vim-ReplaceWithRegister")

