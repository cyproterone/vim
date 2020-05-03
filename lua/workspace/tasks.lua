local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Files Region ####################

local fs_consistency = function ()

  -- auto load changes
  bindings.set("autoread")

  bindings.auto{events = {"FocusGained", "BufEnter"},
                exec = "checktime"}

  -- auto save file
  bindings.set("autowrite")
  bindings.set("autowriteall")

end
registry.defer(fs_consistency)


-- autosave
registry.install("907th/vim-auto-save")
local autosave = function ()

  -- auto backup
  -- bindings.set("backup")

  bindings.let("auto_save", true)
  bindings.let("auto_save_write_all_buffers", true)
  bindings.let("auto_save_events", {"TextChanged","InsertLeave"})
  bindings.let("auto_save_silent", true)

end
registry.defer(autosave)
