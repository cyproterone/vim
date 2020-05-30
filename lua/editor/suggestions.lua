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
  bindings.map.insert("<C-q>", "<C-e>")

  -- cua
  bindings.map.insert("<CR>", "pumvisible() ? (complete_info().selected == -1 ? '<C-y><CR>' : '<C-y>') : '<CR>'",  {expr = true})

  bindings.map.insert("<Tab>",   "pumvisible() ? '<C-n>' : '<Tab>'", {expr = true})
  bindings.map.insert("<S-Tab>", "pumvisible() ? '<C-p>' : '<BS>'",  {expr = true})

  -- previous
  bindings.map.insert("<C-p>", "<C-x><C-p>")
  -- next
  bindings.map.insert("<C-n>", "<C-x><C-n>")
  -- line
  bindings.map.insert("<C-l>", "<C-x><C-l>")
  -- file
  bindings.map.insert("<C-f>", "<C-x><C-f>")
  -- omnifunc
  bindings.map.insert("<C-o>", "<C-x><C-o>")
  -- userfunc
  bindings.map.nv("<C-space>")
  bindings.map.insert("<C-Space>", "<C-x><C-u>")

end
registry.defer(hotkeys)


--#################### Auto Region ####################

-- needs :UpdateRemotePlugins
registry.install("Shougo/deoplete.nvim")
local enable = function ()

  fn["deoplete#custom#option"]("auto_complete_delay", 0)

  -- keys
  lua_enable_comp = function ()
    fn["deoplete#enable"]()
    print("-- 蛙 --")
  end
  bindings.map.normal("gz", ":lua lua_enable_comp()<CR>")

end
registry.defer(enable)


registry.install("Shougo/deoplete-lsp")
