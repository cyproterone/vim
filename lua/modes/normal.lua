local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Normal Region ####################

-- fix cursor pos moving 1 back
local no_stepback = function ()

  local record_pos = function ()
    local _, c = unpack(api.nvim_win_get_cursor(0))
    vim.b._buf_cursor_pos_ = c
  end

  local displace = function ()
    local r, c = unpack(api.nvim_win_get_cursor(0))
    local pos = vim.b._buf_cursor_pos_
    if c ~= pos then
      api.nvim_win_set_cursor(0, {r, pos})
    end
  end

  registry.auto({"InsertEnter", "CursorMovedI"}, record_pos)
  registry.auto("InsertLeave", displace)

end
registry.defer(no_stepback)


local remap = function ()

    -- normalize Y
  bindings.map.normal("Y", "y$")

end
registry.defer(remap)

