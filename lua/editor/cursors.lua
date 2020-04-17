local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Cursors Region ####################

-- auto centering on entering insertion mode
local auto_centre = function ()

  bindings.auto{ group = "auto_centering",
                 events = { "InsertEnter" },
                 exec = "normal! zz", }

end
table.insert(defer, auto_centre)


-- expand selection
table.insert(plugins, "terryma/vim-expand-region")


-- multi cursors
table.insert(plugins, "terryma/vim-multiple-cursors")


-- drag regions around
table.insert(plugins, "matze/vim-move")


-- easy quoting
table.insert(plugins, "tpope/vim-surround")


-- auto parens
table.insert(plugins, "Raimondi/delimitMate")


return {
  plugins = plugins,
  defer = defer,
}
