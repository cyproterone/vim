local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Insert Region ####################

-- add some emacs keys
local emacs_keys = function ()

  -- delete to end of line
  bindings.map.insert("<C-k>", "<C-o>D")

  bindings.map.insert("<M-Left>", "<C-Left>")
  bindings.map.insert("<M-Right>", "<C-Right>")
  bindings.map.insert("<M-Up>", "<C-Up>")
  bindings.map.insert("<M-Down>", "<C-Down>")

end
registry.defer(emacs_keys)


-- add a cursor cross in insert mode
local cursor_cross = function ()

  local show = function ()

  end

  local hide = function ()

  end

  registry.auto("InsertEnter", show)
  registry.auto("InsertLeave", hide)

end
registry.defer(cursor_cross)
