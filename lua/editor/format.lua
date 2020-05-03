local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Format Region ####################

-- align text
registry.install("junegunn/vim-easy-align")


-- prettiers
registry.install("sbdchd/neoformat")
local pretty = function ()

end
registry.defer(pretty)
