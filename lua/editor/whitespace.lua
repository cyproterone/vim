local bindings = require "libs/bindings"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Whitespace Region ####################

-- try to guess table size
registry.install("tpope/vim-sleuth")
local tab_size = function ()

  -- how big are tabs ?
  bindings.set("tabstop", 2)

  -- spaces remove on deletion
  bindings.set("softtabstop", 2)

  -- manual indentation width
  bindings.set("shiftwidth", 2)

end
registry.defer(tab_size)


local unsurprising_tab = function ()

  -- insert spaces instead of tabs
  bindings.set("expandtab")

  -- smart indentation level
  bindings.set("autoindent")
  bindings.set("smarttab")

end
registry.defer(unsurprising_tab)


-- remove trailing whitespace
local trailing_whitespace = function ()

  local strip = function ()
    local m = api.nvim_get_mode()
    if m.mode ~= "n" then
      return
    else
      local row, col = unpack(api.nvim_win_get_cursor(0))
      local lines = api.nvim_buf_get_lines(0, 0, -1, true)

      local trimmable = true
      for i in std.range(#lines, 1, -1) do
        local line = lines[i]
        local new_line = string.gsub(line, "%s$", "")
        trimmable = trimmable and i > row and new_line == ""
        if trimmable then
          lines[i] = nil
        elseif i ~= row then
          lines[i] = new_line
        end
      end

      api.nvim_buf_set_lines(0, 0, -1, true, lines)
      api.nvim_win_set_cursor(0, {row, col})
    end
  end

  registry.auto("BufWritePre", strip, "*", "silent undojoin |")

end
registry.defer(trailing_whitespace)
