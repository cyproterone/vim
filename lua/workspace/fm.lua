local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

registry.install("kyazdani42/nvim-tree.lua")
registry.install("kyazdani42/nvim-web-devicons")

local options = function ()

  -- dont auto expand tree
  vim.g.lua_tree_follow = 0

end
registry.defer(options)


local key = function ()

  local remap = function ()

    bindings.map.normal("R", ":LuaTreeRefresh<CR>")

    lv.tree_preview = function ()
      local pos = api.nvim_win_get_cursor(0)
      local tree = require "tree"
      tree.on_keypress("edit")
      bindings.exec[[LuaTreeClose]]
      bindings.exec[[LuaTreeOpen]]
      api.nvim_win_set_cursor(0, pos)
    end

    bindings.map.normal("<Tab>", ":lua lv.tree_preview()<CR>")

  end
  registry.auto("FileType", remap, "LuaTree")

  bindings.map.normal("<Leader>i", ":LuaTreeToggle<CR>")

end
registry.defer(key)

