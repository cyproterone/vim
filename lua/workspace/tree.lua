local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### Tree Region ####################

table.insert(plugins, "preservim/nerdtree")
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
  bindings.map.normal("<Leader>i", ":NERDTreeToggle<CR>")

  -- nerdtree bindings
  bindings.let("NERDTreeMapActivateNode", "<Tab>")
  bindings.let("NERDTreeMapPreview", "d")

end
table.insert(defer, tree)


--#################### Tree Region ####################

table.insert(plugins, "Xuyuanp/nerdtree-git-plugin")
table.insert(plugins, "tiagofumo/vim-nerdtree-syntax-highlight")
local pretty_tree = function ()

  bindings.let("NERDTreeHighlightFolders", true)

end
table.insert(defer, tree)


return {
  plugins = plugins,
  defer = defer,
}
