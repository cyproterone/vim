local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Tree Region ####################

if fn.has("nvim") then
  registry.install{"Shougo/defx.nvim", ["do"] = ":UpdateRemotePlugins"}
  local tree = function ()

  end
  registry.defer(tree)
else
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

  end
  registry.defer(tree)


  registry.install("Xuyuanp/nerdtree-git-plugin")
  registry.install("tiagofumo/vim-nerdtree-syntax-highlight")
  local pretty_tree = function ()

    bindings.let("NERDTreeHighlightFolders", true)

  end
  registry.defer(pretty_tree)
end
