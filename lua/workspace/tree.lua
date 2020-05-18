local std = require "libs/std"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Tree Region ####################

if bindings.executable("ranger") then
  local tree = function ()

    local ranger1 = " --cmd='set preview_files=true'"
    local ranger2 = " --cmd='set use_preview_script=true'"
    local ranger = "ranger" .. ranger1 .. ranger2

    -- keybindings
    bindings.map.normal("<Leader>i", ":FloatermNew " .. ranger .. "<CR>")

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
