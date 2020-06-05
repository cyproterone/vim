local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Cursors Region ####################

-- drag regions around
registry.install("matze/vim-move")
local vim_move = function ()

  bindings.map.normal("<M-Up>",   "<Plug>MoveLineUp",    {noremap = false})
  bindings.map.normal("<M-Down>", "<Plug>MoveLineDown",  {noremap = false})

  bindings.map.visual("<M-Up>",   "<Plug>MoveBlockUp",   {noremap = false})
  bindings.map.visual("<M-Down>", "<Plug>MoveBlockDown", {noremap = false})

end
registry.defer(vim_move)


-- auto parens
registry.install("Raimondi/delimitMate")
local match_cursor = function ()

  bindings.set("matchpairs", "<:>", [[+=]])

end
registry.defer(match_cursor)
