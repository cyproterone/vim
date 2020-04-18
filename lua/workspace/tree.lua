local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Tree Region ####################

table.insert(plugins, "preservim/nerdtree")
table.insert(plugins, "Xuyuanp/nerdtree-git-plugin")
local tree = function ()

  -- show hiddenfiles
  bindings.let("NERDTreeShowHidden", true)

  -- buffer move with cursor
  bindings.let("NERDTreeAutoCenter", true)

  -- change cwd on root move
  bindings.let("NERDTreeChDirMode", 2)

  -- remove buffer on file delete
  bindings.let("NERDTreeAutoDeleteBuffer", true)


  -- keybindings
  bindings.map.normal("<Leader>b", ":NERDTreeToggle<CR>")

  -- nerdtree bindings
  bindings.let("NERDTreeMapActivateNode", "<Tab>")
  bindings.let("NERDTreeMapPreview", "<Space>")

end
table.insert(defer, tree)


return {
  plugins = plugins,
  defer = defer,
}
