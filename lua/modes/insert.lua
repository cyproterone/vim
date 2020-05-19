local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Insert Region ####################

-- add some emacs keys
local emacs_keys = function ()

  -- delete to end of line
  bindings.map.insert("<C-k>", "<C-o>D")

end
registry.defer(emacs_keys)

