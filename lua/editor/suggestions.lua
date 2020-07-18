local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 15)

  -- transparency
  bindings.set("pumblend", 5)

  -- dont show suggestions menu
  bindings.set("shortmess", "c", [[+=]])

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- complete menu
  bindings.set("completeopt", "menuone,preview,noinsert,noselect")

end
registry.defer(suggestions)


local hotkeys = function ()

  -- cancel comp
  bindings.map.insert("<esc>", "pumvisible() ? (complete_info().selected == -1 ? '<c-e>' : '<c-y>') : '<esc>'",  {expr = true})
  bindings.map.insert("<c-q>", "<esc>")

  -- cua
  bindings.map.insert("<cr>", "pumvisible() ? (complete_info().selected == -1 ? '<c-y><cr>' : '<c-y>') : '<cr>'",  {expr = true})

  bindings.map.insert("<tab>",   "pumvisible() ? '<c-n>' : '<tab>'", {expr = true})
  bindings.map.insert("<s-tab>", "pumvisible() ? '<c-p>' : '<bs>'",  {expr = true})

  -- previous
  bindings.map.insert("<c-p>", "<c-x><c-p>")
  -- next
  bindings.map.insert("<c-n>", "<c-x><c-n>")
  -- line
  bindings.map.insert("<c-l>", "<c-x><c-l>")
  -- file
  bindings.map.insert("<c-f>", "<c-x><c-f>")
  -- omnifunc
  bindings.map.insert("<c-o>", "<c-x><c-o>")
  -- userfunc
  bindings.map.nv("<c-space>")
  bindings.map.insert("<c-space>", "<c-x><c-o>")

end
registry.defer(hotkeys)


--#################### Auto Region ####################

registry.install("ms-jpq/fast-comp", {["branch"] = "nvim", ["do"] = ":UpdateRemotePlugins"})
local keybind = function ()

  bindings.map.normal("gz", "<cmd>FCstart<cr>")

end
registry.defer(keybind)
