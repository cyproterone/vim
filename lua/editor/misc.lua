local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Misc Region ####################

-- auto parens
local delimit = function ()

  local match_pairs = {
    ["{"] = "{}",
    ['"'] = '""',
    ["'"] = "''"
  }

  local de = function ()
    local char = match_pairs[vim.v.char]
    if char then
      vim.v.char = char
      local row, col = unpack(api.nvim_win_get_cursor(0))
      vim.schedule(function ()
        api.nvim_win_set_cursor(0, {row, col + 1})
      end)
    end
  end
  registry.auto("InsertCharPre", de)

end
registry.defer(delimit)
