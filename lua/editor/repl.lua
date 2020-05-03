local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Repl Region ####################

registry.install("metakirby5/codi.vim")
local repl = function ()

end
registry.defer(repl)
