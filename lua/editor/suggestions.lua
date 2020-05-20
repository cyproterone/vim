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

  -- user comp func
  bindings.set("completefunc", "")

end
registry.defer(suggestions)


local hotkeys = function ()

  -- cancel comp
  bindings.map.insert("<C-q>", "<C-e>")

  -- cua
  -- bindings.map.insert("<Esc>",   "pumvisible() ? '<C-e>' : '<Esc>'", {expr = true})
  bindings.map.insert("<CR>",    "pumvisible() ? '<C-y>' : '<CR>'",  {expr = true})
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
  -- userfunc
  bindings.map.insert("<C-u>", "<C-x><C-u>")
  -- omnifunc
  bindings.map.insert("<C-o>", "<C-x><C-o>")
  bindings.map.nv("<C-space>")
  bindings.map.insert("<C-Space>", "<C-x><C-o>")

end
registry.defer(hotkeys)


--#################### Auto Region ####################

-- needs :UpdateRemotePlugins
registry.install("Shougo/deoplete.nvim")
local enable = function ()

  fn["deoplete#custom#option"]("auto_complete_delay", 200)

  -- keys
  lua_enable_comp = function ()
    fn["deoplete#enable"]()
    print("-- 蛙 --")
  end
  bindings.map.normal("gz", ":lua lua_enable_comp()<CR>")

end
registry.defer(enable)


registry.install("Shougo/deoplete-lsp")
registry.install{"tbodt/deoplete-tabnine", ["do"] = "./install.sh"}
local tabnine = function ()

  fn["deoplete#custom#option"]("sources", {_ = {"lsp", "tabnine"}})

  fn["deoplete#custom#source"]("tabnine", {rank = 200})
  fn["deoplete#custom#var"]("tabnine", {
    line_limit = 96,
    max_num_results = 6})

end
registry.defer(tabnine)

