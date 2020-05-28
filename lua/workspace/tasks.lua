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
    local bufs = api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      local modified = api.nvim_buf_get_option(buf, "modified")
      if modified ~= "nomodified" then
        bindings.exec("silent! wa")
        break
      end
    end
  end

  registry.auto(
    {"TextChanged", "InsertLeave", "CursorHoldI"},
    save,
    {"*"},
    "nested")

end
registry.defer(autosave)
