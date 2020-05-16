local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Tree Region ####################

registry.install("preservim/nerdtree")
local tree = function ()

  local file_home = var_home .. "/nerdtree"

  -- show hiddenfiles
  bindings.let("NERDTreeShowHidden", true)

  -- buffer move with cursor
  bindings.let("NERDTreeAutoCenter", true)

  -- change cwd on root move
  bindings.let("NERDTreeChDirMode", 2)

  -- remove buffer on file delete
  bindings.let("NERDTreeAutoDeleteBuffer", true)

  -- bookmark file location
  bindings.let("NERDTreeBookmarksFile", file_home .. "/nerdtree_bookmarks")

  -- keybindings
  bindings.map.normal("<Leader>i", ":NERDTreeToggle<CR>")

  -- nerdtree bindings
  bindings.let("NERDTreeMapActivateNode", "<Tab>")
  bindings.let("NERDTreeMapPreview", "d")


  -- disable sign column
  local sign_col = function ()
    local buf = bindings.call("expand", {"<abuf>"})
    local win = bindings.call("bufwinid", {tonumber(buf)})
    bindings.win.set(win, "signcolumn", "no")
  end

  registry.auto("FileType", sign_col, "nerdtree")

end
registry.defer(tree)


--#################### Tree Region ####################

registry.install("Xuyuanp/nerdtree-git-plugin")
registry.install("tiagofumo/vim-nerdtree-syntax-highlight")
local pretty_tree = function ()

  bindings.let("NERDTreeHighlightFolders", true)

end
registry.defer(tree)
