local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### File Manager Region ####################

-- fff
table.insert(plugins, "dylanaraps/fff.vim")
local fff = function ()

  --- keybind conflict
  bindings.arbitrary([[command! -nargs=* -complete=dir FFF call fff#Run(<q-args>)]])

  -- fff keybind
  bindings.map.normal("<Leader>i", ":FFF<CR>")

  bindings.let("fff#split", "new")

end
table.insert(defer, fff)


return {
  plugins = plugins,
  defer = defer,
}
