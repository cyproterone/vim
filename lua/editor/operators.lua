local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Operators Region ####################

-- cs, ys, ds
registry.install("tpope/vim-surround")

-- gc :: go comment
registry.install("tpope/vim-commentary")

-- ga :: go align
registry.install("junegunn/vim-easy-align")
local align = function ()

  bindings.map.nv("ga", "<Plug>(EasyAlign)", {noremap = false})

end
registry.defer(align)

