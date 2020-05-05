local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Files Region ####################

local fs_consistency = function ()

  -- auto load changes
  bindings.set("autoread")

  local reload_file = function ()
    bindings.exec("checktime")
  end

  registry.auto({"FocusGained", "BufEnter"}, reload_file)

  -- auto save file
  bindings.set("autowrite")
  bindings.set("autowriteall")

end
registry.defer(fs_consistency)


-- autosave
local autosave = function ()

  -- auto backup
  -- bindings.set("backup")

  local save = function ()
    bindings.exec("silent! wa")
  end
  registry.auto({"TextChanged", "InsertLeave", "CursorHoldI"}, save)

end
registry.defer(autosave)
