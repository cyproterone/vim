local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 15)

  -- transparency
  bindings.set("pumblend", 5)

  -- dont spam suggestions menu
  bindings.set("shortmess", "c", [[+=]])

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- complete menu
  bindings.set("completeopt", "menuone,preview,noinsert,noselect")

end
registry.defer(suggestions)


local hotkeys = function ()

  -- cancel comp
  bindings.map.insert("<esc>", "pumvisible() ? '<c-e><esc>' : '<esc>'", {expr = true})
  bindings.map.insert("<bs>",  "pumvisible() ? '<c-e><bs>'  : '<bs>'",  {expr = true})

  -- cua
  bindings.map.insert("<cr>", "pumvisible() ? (complete_info().selected == -1 ? '<c-e><cr>' : '<c-y>') : '<cr>'",  {expr = true})

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

registry.install("ms-jpq/kok.nvim",     {["branch"] = "kok", ["do"] = ":UpdateRemotePlugins"})
-- registry.install("ms-jpq/kok-t9",       {["branch"] = "kok", ["do"] = ":UpdateRemotePlugins"})
-- registry.install("ms-jpq/kok-snippets", {["branch"] = "kok", ["do"] = ":UpdateRemotePlugins"})
-- registry.install("honza/vim-snippets")
-- registry.install("Shougo/neosnippet-snippets")
local keybind = function ()

  bindings.map.normal("gz", "<cmd>KoKstart<cr>")

  bindings.set("completefunc", "KoKomnifunc")

  vim.g.narc_settings = {
    logging_level = "DEBUG",
    sources = {lsp = {enabled = true}}
  }

  vim.g.narc_snippet_sources = {
    snipmate = {"vim-snippets/snippets"},
    ultisnips = {"vim-snippets/UltiSnips"},
    neosnippet = {"neosnippet-snippets/neosnippets"},
  }

end
registry.defer(keybind)
