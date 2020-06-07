local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

registry.install("kyazdani42/nvim-tree.lua")
registry.install("kyazdani42/nvim-web-devicons")



local key = function ()
  bindings.map.normal("<Leader>i", ":LuaTreeToggle<CR>")
end
registry.defer(key)


local theme = function ()
  -- vim.g.defx_icons_enable_syntax_highlight = false

  -- neat idea, doesn't work
  -- fn["defx#custom#column"]("git", "show_ignored", false)
end
registry.defer(theme)
