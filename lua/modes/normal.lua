local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap ROT13
  bindings.map.normal("g?")

end
registry.defer(unmap_keys)


local map_keys = function ()

  -- dont go into ex mode
  bindings.map.command("<C-f>")

  -- use q to insert single char
  bindings.map.normal("q", "a🦄<Esc>r")
  bindings.map.normal("Q", "i🦄<Esc>r")

  -- use @ to do ^
  bindings.map.normal("@", "^")

end
registry.defer(map_keys)


-- fix cursor pos moving 1 back
local no_stepback = function ()

  local buf_cursor_pos = "_buf_cursor_pos_"

  local record_pos = function ()
    local c = bindings.call("col", {"."})
    api.nvim_buf_set_var(0, buf_cursor_pos, c)
  end

  local displace = function ()
    local c = bindings.call("col", {"."})
    local pos = api.nvim_buf_get_var(0, buf_cursor_pos)
    if c ~= pos then
      bindings.call("cursor", {0, pos})
    end
  end

  registry.auto({"InsertEnter", "CursorMovedI"}, record_pos)
  registry.auto("InsertLeave", displace)

end
registry.defer(no_stepback)

