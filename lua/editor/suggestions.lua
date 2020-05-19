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
  bindings.set("completeopt", "menuone,noinsert,noselect", [[+=]])

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
  -- omnifunc
  bindings.map.insert("<C-o>", "<C-x><C-o>")
  bindings.map.normal("<C-space>")
  bindings.map.insert("<C-Space>", "<C-x><C-o>")

end
registry.defer(hotkeys)


--#################### Auto Region ####################
local enable = function ()

  lua_enable_comp = function ()
    if not fn.has("nvim") then
      print("-- 无用 --")
    else
      fn["deoplete#enable"]()
      print("-- 蛙 --")
    end
  end

  -- keys
  bindings.map.normal("gz", ":lua lua_enable_comp()<CR>")

end
registry.defer(enable)


-- needs :UpdateRemotePlugins
registry.install("Shougo/deoplete.nvim")
registry.install("Shougo/deoplete-lsp")
registry.install{"tbodt/deoplete-tabnine", ["do"] = "./install.sh"}
local comp = function ()

  -- registry
  local setopt = fn["deoplete#custom#option"]
  local getopt = fn["deoplete#custom#_get"]
  registry.const["omni"] = function (filetype, sources)
    local opt = getopt().option
    local omni = opt["omni_patterns"]
    omni[filetype] = sources
    setopt("omni_patterns", omni)
  end


  -- options
  setopt("sources", {_ = {"tabnine"}})
  fn["deoplete#custom#var"]("tabnine", {
    line_limit = 96,
    max_num_results = 6})

end
registry.defer(comp)
