local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 10)
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
  bindings.map.insert("<c-q>", "<c-e>")

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
  bindings.map.insert("<c-space>", "<c-x><c-u>")

end
registry.defer(hotkeys)


--#################### Auto Region ####################

registry.install("ms-jpq/fast-comp", {["branch"] = "nvim", ["do"] = ":UpdateRemotePlugins"})
local keybind = function ()

  bindings.map.normal("gx", "<cmd>FCstart<cr>")

end
registry.defer(keybind)


registry.install("Shougo/deoplete.nvim", {["do"] = ":UpdateRemotePlugins"})
registry.install("Shougo/deoplete-lsp")
local enable = function ()

  fn["deoplete#custom#option"]("auto_complete_delay", 0)

  -- keys
  lv.enable_comp = function ()
    fn["deoplete#enable"]()
    api.nvim_out_write("-- 蛙 --\n")
  end
  bindings.map.normal("gz", "<cmd>lua lv.enable_comp()<cr>")

end
registry.defer(enable)
