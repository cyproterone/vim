local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Insert Region ####################

-- add some emacs keys
local emacs_keys = function ()

  -- delete to end of line
  bindings.map.insert("<C-k>", "<C-o>D")

end
registry.defer(emacs_keys)


-- add a cursor cross in insert mode
local cursor_cross = function ()

  local show = function ()
    bindings.set("cursorcolumn")
  end

  local hide = function ()
    bindings.set("nocursorcolumn")
  end

  registry.auto("InsertEnter", show)
  registry.auto("InsertLeave", hide)

end
registry.defer(cursor_cross)
