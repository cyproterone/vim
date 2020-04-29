local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

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
table.insert(defer, misc)


local scroll = function ()

  -- allow scrolling pass EOF
  bindings.set("scrolloff", 1)
  bindings.set("sidescrolloff", 3)

end
table.insert(defer, scroll)


local performance = function ()

  bindings.set("ttyfast")
  -- TODO: this might cause issues
  -- bindings.set("lazyredraw")

end
table.insert(defer, performance)


-- clean up where files are stored
local var_files = function ()

  -- backup files
    bindings.set("backupdir", var_home .. "/backup//")

    -- undo files
    bindings.set("undodir", var_home .. "/undo//")

    -- swap files
    bindings.set("directory", var_home .. "/swap//")

end
table.insert(defer, var_files)


local welcome_screen = function ()

  -- remove welcome message
  bindings.set("shortmess", "I", [[+=]])

end
table.insert(defer, welcome_screen)


return {
  plugins = plugins,
  defer = defer,
}
