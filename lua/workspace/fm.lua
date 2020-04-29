local bindings = require "libs/bindings"


local plugins = {}
local defer = {}
local functions = {}

--#################### File Manager Region ####################

-- fff
table.insert(plugins, "dylanaraps/fff.vim")
local fff = function ()

  --- keybind conflict
  bindings.exec([[command! -nargs=* -complete=dir FFF call fff#Run(<q-args>)]])

  -- fff keybind
  bindings.map.normal("<Leader>I", ":FFF<CR>")

  bindings.let("fff#split", "new")

end
table.insert(defer, fff)


-- netrw
local netrw = function ()

  bindings.auto{
    group = "netrw_fm",
    events = "FileType",
    filter = "netrw",
    exec = "setlocal bufhidden=wipe"}

end
table.insert(defer, netrw)


-- ranger
table.insert(plugins, {"kevinhwang91/rnvimr", ["do"] = "make sync"})
local ranger = function ()

  bindings.map.normal("<Leader>b", ":RnvimrToggle<CR>")

end
table.insert(defer, ranger)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}
