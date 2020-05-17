local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Suggestions Region ####################

local suggestions = function ()

  -- dont show too many opts
  bindings.set("pumheight", 10)
  -- transparency
  bindings.set("pumblend", 10)

  -- dont show suggestions menu
  bindings.set("shortmess", "c", [[+=]])

  -- dont follow tags
  bindings.set("complete", "i", [[-=]])

  -- complete menu
  bindings.set("completeopt", "menuone,noinsert,noselect", [[+=]])

end
registry.defer(suggestions)


local hotkeys = function ()

  -- map c-space for completion
  bindings.map.insert("<C-space>", "<C-x>")
  bindings.map.normal("<C-space>")

  -- cancel comp
  bindings.map.insert("<C-q>", "<C-e>")

  --
  -- c-p :: before
  -- c-n :: after
  -- c-l :: line
  -- c-f :: files
  -- c-o :: omni-func
  --

  --
  -- c-k :: dictionary
  -- c-t :: thesaurus
  -- c-s :: spellcheck
  --

end
registry.defer(hotkeys)


if fn.has("nvim") then
  registry.install{"Shougo/deoplete.nvim", ["do"] = ":UpdateRemotePlugins"}
  registry.install("Shougo/deoplete-lsp")

  local tab_comp =function ()

    -- registry
    local setopt = fn["deoplete#custom#option"]
    local getopt = fn["deoplete#custom#_get_option"]
    registry.const("deo_set", setopt)
    registry.const("deo_get", getopt)


    -- options
    setopt("auto_complete_delay", 200)
    setopt("sources", {_ = {"around", "buffer"}})


    -- bindings.let("deoplete#enable_at_startup", true)

  end
  registry.defer(tab_comp)
end

