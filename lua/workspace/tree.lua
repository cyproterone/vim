local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Tree Region ####################

table.insert(plugins, "preservim/nerdtree")
table.insert(plugins, "Xuyuanp/nerdtree-git-plugin")
local tree = function ()

  -- default settings
  bindings.let("NERDTreeShowHidden", 1)

  -- keybindings
  bindings.map.normal("<Leader>b", ":NERDTreeToggle<CR>")

end
table.insert(defer, tree)


return {
  plugins = plugins,
  defer = defer,
}
