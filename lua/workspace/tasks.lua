local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Files Region ####################

local fs_consistency = function ()

  -- auto save file
  bindings.set("autowrite")
  bindings.set("autowriteall")

end
table.insert(defer, fs_consistency)


-- autosave
table.insert(plugins, "907th/vim-auto-save")
local autosave = function ()

  bindings.let("auto_save", true)
  bindings.let("auto_save_write_all_buffers", true)
  bindings.let("auto_save_events", {"InsertLeave"})

end
table.insert(defer, autosave)


return {
  plugins = plugins,
  defer = defer,
}
