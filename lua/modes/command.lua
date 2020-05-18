local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  -- dont go into ex mode
  bindings.map.command("<C-f>")

  bindings.map.command("<C-q>", "<Esc>")

  -- enable paste
  bindings.map.command("<C-v>", [[<C-r>"]], {silent = false})

end
registry.defer(keys)
