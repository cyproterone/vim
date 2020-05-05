local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Terminal Region ####################

local hotkeys = function ()

  bindings.map.terminal("<Esc>", [[<C-\><C-n>]])

end
registry.defer(hotkeys)


local terminal = function ()

  local auto_insert = function ()
    local buf = bindings.call("expand", {"<abuf>"})
    local fst = bindings.buf.var(buf, "terminal_entered")
    if not fst then
      bindings.exec("startinsert")
    end
    bindings.buf.let(buf, "terminal_entered", true)
  end

  registry.auto("CmdwinEnter", auto_insert)

end
registry.defer(terminal)


