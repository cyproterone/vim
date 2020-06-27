local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Git Region ####################

-- lazygit
local lg = function ()

  bindings.map.normal("<Leader>U", "<cmd>FloatermNew lazygit<CR>")

end
registry.defer(lg)


-- gitter
-- registry.install("airblade/vim-gitgutter")
