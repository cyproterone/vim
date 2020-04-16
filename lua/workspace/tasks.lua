local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Files Region ####################

table.insert(plugins, "vim-scripts/vim-auto-save")

local fs_consistency = function ()
  -- auto load fs changes
  bindings.set("autoread")

  -- auto save
  bindings.let("auto_save", 1)
end
table.insert(defer, fs_consistency)


return {
  plugins = plugins,
  defer = defer,
}
