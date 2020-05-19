local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Git Region ####################

-- lazygit
local lg = function ()

  bindings.map.normal("<Leader>U", ":FloatermNew lazygit<CR>")
  bindings.map.normal("<Leader>y", ":FloatermNew tig<CR>")

end
registry.defer(lg)


-- gitter
registry.install("airblade/vim-gitgutter")
