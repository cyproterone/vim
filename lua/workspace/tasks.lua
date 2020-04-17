local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Files Region ####################

local fs_consistency = function ()

  -- auto load fs changes
  bindings.set("autoread")

  -- auto write on buffer leave
  bindings.set("autowrite")

end
table.insert(defer, fs_consistency)


-- autosave
table.insert(plugins, "vim-scripts/vim-auto-save")
local autosave = function ()

  bindings.let("auto_save", 0)

end
table.insert(defer, autosave)


return {
  plugins = plugins,
  defer = defer,
}
