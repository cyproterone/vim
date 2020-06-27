local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Command Region ####################

-- bring over some emacs hotkeys
local keys = function ()

  -- dont go into ex mode
  bindings.map.command("<c-f>")

  bindings.map.command("<c-q>", "<esc>")

  -- enable paste
  bindings.map.command("<c-v>", [[<c-r>"]], {silent = false})

end
registry.defer(keys)
