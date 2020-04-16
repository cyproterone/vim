local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Misc Region ####################

local misc = function ()

  bindings.set("nocompatible")
  bindings.set("encoding", "utf-8")
  bindings.set("ttyfast")

  -- show as much as possible
  bindings.set("display", "lastline", [[+=]])

  -- viminfo include !
  bindings.set("viminfo", "!", [[+=]])

end
table.insert(defer, misc)


-- clean up where files are stored
local var_files = function ()

  -- backup files
  bindings.set("backupdir", var_home .. "/backup//")

  -- undo files
  bindings.set("undodir", var_home .. "/undo//")

  -- swap files
  bindings.set("directory", var_home .. "/swap//")

end


return {
  plugins = plugins,
  defer = defer,
}
