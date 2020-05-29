local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Cursors Region ####################

-- drag regions around
registry.install("matze/vim-move")


-- auto parens
registry.install("Raimondi/delimitMate")
local match_cursor = function ()

  bindings.set("matchpairs", [[<:>,":",':']], [[+=]])

end
registry.auto(match_cursor)
