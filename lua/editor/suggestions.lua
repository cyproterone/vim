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


  -- cua comp
  local remap = "inoremap <silent><expr> "
  -- bindings.exec(remap .. [[<Esc>   pumvisible() ? "\<C-e>" : "\<Esc>"]])
  bindings.exec(remap .. [[<CR>    pumvisible() ? "\<C-y>" : "\<CR>" ]])
  bindings.exec(remap .. [[<Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]])
  bindings.exec(remap .. [[<S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"]])


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

end
registry.defer(hotkeys)


if fn.has("nvim") then
  registry.install{"Shougo/deoplete.nvim", ["do"] = ":UpdateRemotePlugins"}
  registry.install("Shougo/deoplete-lsp")

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
    setopt("auto_complete_delay", 200)
    setopt("sources", {_ = {"around", "buffer"}})

    -- abbr
    bindings.exec[[command! Deo call deoplete#enable()]]

  end
  registry.defer(comp)
end

