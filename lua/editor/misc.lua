local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Misc Region ####################

-- auto parens
local delimit = function ()

  local match_pairs = {
    ["{"] = "}",
    ["["] = "]",
    ["("] = ")",
    ['"'] = '"',
    ["'"] = "'",
    ["`"] = "`",
  }

  local match_cond = function (lhs, rhs)
    if lhs ~= rhs then
      return true
    else
      local line = api.nvim_get_current_line()
      local count = 0
      for i = 1, #line do
        local c = string.sub(line, i, i)
        if c == rhs then
          count = count + 1
        end
      end
      return count % 2 == 0
    end
  end

  local de = function ()
    local lhs = vim.v.char
    local rhs = match_pairs[vim.v.char]
    if rhs and match_cond(lhs, rhs) then
      vim.v.char = lhs .. rhs
      local row, col = unpack(api.nvim_win_get_cursor(0))
      vim.schedule(function ()
        api.nvim_win_set_cursor(0, {row, col + 1})
      end)
    end
  end
  registry.auto("InsertCharPre", de)

end
registry.defer(delimit)
