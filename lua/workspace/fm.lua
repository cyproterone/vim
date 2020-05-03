local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

-- fff
registry.install("dylanaraps/fff.vim")
local fff = function ()

  --- keybind conflict
  bindings.exec([[command! -nargs=* -complete=dir FFF call fff#Run(<q-args>)]])

  -- fff keybind
  bindings.map.normal("<Leader>I", ":FFF<CR>")

  bindings.let("fff#split", "new")

end
registry.defer(fff)


-- netrw
local netrw = function ()

  bindings.auto{events = "FileType",
                filter = "netrw",
                exec = "setlocal bufhidden=wipe"}

end
registry.defer(netrw)


-- ranger
registry.install({"kevinhwang91/rnvimr", ["do"] = "make sync"})
local ranger = function ()

  bindings.map.normal("<Leader>b", ":RnvimrToggle<CR>")

end
registry.defer(ranger)
