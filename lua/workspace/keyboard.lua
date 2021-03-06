local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Keyboard Region ####################

local leader = function ()

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

end
registry.pre(leader)


local misc = function ()

  -- waiting time within a key sequence
  bindings.set("timeoutlen", 500)

end
registry.defer(misc)


local normalize_keystrokes = function ()

  -- allow nav keys to wrap around
  bindings.set("whichwrap", "h,l,<,>,[,]", [[+=]])

end
registry.defer(normalize_keystrokes)
