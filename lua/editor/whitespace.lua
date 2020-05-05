local bindings = require "libs/bindings"
local registry = require "libs/registry"


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
    end
    local l = bindings.call("line", {"."})
    local c = bindings.call("col", {"."})
    bindings.exec[[%s/\s\+$//e]]
    bindings.call("cursor", {l, c})
  end

  registry.auto("BufWritePre", strip)

end
registry.defer(trailing_whitespace)
