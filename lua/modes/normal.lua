local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Normal Region ####################

local unmap_keys = function ()

  -- unmap exmode
  bindings.map.normal("Q", "<Esc>")

end
registry.defer(unmap_keys)


local map_keys = function ()

  -- use @ to do ^
  bindings.map.normal("@", "^")
  bindings.map.normal("^", "@")

end
registry.defer(map_keys)


-- fix cursor pos moving 1 back
local no_stepback = function ()

  local buf_cursor_pos = "_buf_cursor_pos_"

  local record_pos = function ()
    local _, c = unpack(api.nvim_win_get_cursor(0))
    bindings.buf(0).let(buf_cursor_pos, c)
  end

  local displace = function ()
    local r, c = unpack(api.nvim_win_get_cursor(0))
    local pos = bindings.buf(0).var(buf_cursor_pos)
    if c ~= pos then
      api.nvim_win_set_cursor(0, {r, pos})
    end
  end

  registry.auto({"InsertEnter", "CursorMovedI"}, record_pos)
  registry.auto("InsertLeave", displace)

end
registry.defer(no_stepback)
