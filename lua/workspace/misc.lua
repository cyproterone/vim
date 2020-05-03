local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Misc Region ####################

local misc = function ()

  bindings.set("encoding", "utf-8")

  -- cursor hold time
  bindings.set("updatetime", 300)

  -- show as much as possible
  bindings.set("display", "lastline", [[+=]])

  -- vim session state
  bindings.set("shada", "!", [[+=]])

  -- min lines changed to report
  bindings.set("report", 0)

  -- use system clipboard
  bindings.set("clipboard", "unnamedplus")

end
registry.defer(misc)


local scroll = function ()

  -- allow scrolling pass EOF
  bindings.set("scrolloff", 1)
  bindings.set("sidescrolloff", 3)

end
registry.defer(scroll)


local performance = function ()

  bindings.set("ttyfast")
  -- TODO: this might cause issues
  -- bindings.set("lazyredraw")

end
registry.defer(performance)


-- clean up where files are stored
local var_files = function ()

  -- backup files
    bindings.set("backupdir", var_home .. "/backup//")

    -- undo files
    bindings.set("undodir", var_home .. "/undo//")

    -- swap files
    bindings.set("directory", var_home .. "/swap//")

end
registry.defer(var_files)


local welcome_screen = function ()

  -- remove welcome message
  bindings.set("shortmess", "I", [[+=]])

end
registry.defer(welcome_screen)
