local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Visual Region ####################

-- more sensible keys
local keys = function ()

  -- keep selected when indenting
  bindings.map.visual("<", "<gv")
  bindings.map.visual(">", ">gv")

  -- dont shirt move too much
  bindings.map.visual("<S-Up>",   "<Up>")
  bindings.map.visual("<S-Down>", "<Down>")

end
registry.defer(keys)
