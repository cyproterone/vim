local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Format Region ####################

-- prettiers
registry.install("sbdchd/neoformat")
local format = function ()

  -- remove default formatter
  bindings.map.normal("gq", ":echom '-- 没有设置格式 --'<CR>")
  bindings.map.normal("gQ", ":echom '-- 没有设置格式 --'<CR>")

end
registry.defer(format)

