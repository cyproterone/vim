local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Tree Region ####################

registry.install("preservim/nerdtree")
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
registry.defer(tree)


--#################### Tree Region ####################

registry.install("Xuyuanp/nerdtree-git-plugin")
registry.install("tiagofumo/vim-nerdtree-syntax-highlight")
local pretty_tree = function ()

  bindings.let("NERDTreeHighlightFolders", true)

end
registry.defer(tree)
