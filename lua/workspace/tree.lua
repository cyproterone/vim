local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Tree Region ####################

table.insert(plugins, "preservim/nerdtree")
table.insert(plugins, "Xuyuanp/nerdtree-git-plugin")
local tree = function ()

  -- show hiddenfiles
  bindings.let("NERDTreeShowHidden", 1)

  -- buffer move with cursor
  bindings.let("NERDTreeAutoCenter", 1)

  -- change cwd on root move
  bindings.let("NERDTreeChDirMode", 2)

  -- remove buffer on file delete
  bindings.let("NERDTreeAutoDeleteBuffer", 1)


  -- keybindings
  bindings.map.normal("<Leader>b", ":NERDTreeToggle<CR>")

  -- nerdtree bindings
  bindings.let("NERDTreeMapActivateNode", [['<Tab>']])

end
table.insert(defer, tree)


return {
  plugins = plugins,
  defer = defer,
}
