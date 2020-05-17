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

end
registry.defer(map_keys)


-- fix cursor pos moving 1 back
local no_stepback = function ()

  local buf_cursor_pos = "_buf_cursor_pos_"

  local record_pos = function ()
    local c = fn.col(".")
    bindings.buf.let(0, buf_cursor_pos, c)
  end

  local displace = function ()
    local c = fn.col(".")
    local pos = bindings.buf.var(0, buf_cursor_pos)
    if c ~= pos then
      fn.cursor(0, pos)
    end
  end

  registry.auto({"InsertEnter", "CursorMovedI"}, record_pos)
  registry.auto("InsertLeave", displace)

end
registry.defer(no_stepback)
