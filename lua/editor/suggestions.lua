local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 10)
  -- transparency
  bindings.set("pumblend", 10)

  -- dont show suggestions menu
  bindings.set("shortmess", "c", [[+=]])

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- complete menu
  bindings.set("completeopt", "menuone,noinsert", [[+=]])

end
registry.defer(suggestions)


local hotkeys = function ()

  -- map c-space for completion
  bindings.map.insert("<C-space>", "<C-x>")
  bindings.map.normal("<C-space>")

  -- cancel comp
  bindings.map.insert("<C-q>", "<C-e>")

end
registry.defer(hotkeys)
