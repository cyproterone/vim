local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  bindings.map.command("<C-q>", "<Esc>")

  -- enable paste
  bindings.map.command("<C-v>", [[<C-r>"]])

end
registry.defer(keys)
