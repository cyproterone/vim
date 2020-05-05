local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Keyboard Region ####################

local misc = function ()

  -- waiting time within a key sequence
  bindings.set("timeoutlen", 500)

end
registry.defer(misc)


local normalize_keystrokes = function ()

  -- allow nav keys to wrap around
  bindings.set("whichwrap", "h,l,<,>,[,]", [[+=]])

  -- normalize backspace in insertion mode
  bindings.set("backspace", "indent,eol,start")

end
registry.defer(normalize_keystrokes)
