local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Terminal Region ####################

local apperance = function ()

  -- set window options
  local win_ui = function ()
    local buf = bindings.call("expand", {"<abuf>"})
    local win = bindings.call("bufwinid", {tonumber(buf)})
    bindings.win.set(win, "signcolumn", "no")
    bindings.win.set(win, "number", false)
  end

  registry.auto("TermOpen", win_ui)

end
registry.defer(apperance)


local hotkeys = function ()

  -- leave terminal
  bindings.map.terminal("<C-g>", [[<C-\><C-n>]])

  -- enter terminal
  bindings.map.normal("<Leader>u", ":terminal<CR>")

end
registry.defer(hotkeys)
