local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Misc Region ####################

-- auto parens
registry.install("Raimondi/delimitMate")
local match_cursor = function ()

  bindings.set("matchpairs", "<:>", [[+=]])

end
registry.defer(match_cursor)
