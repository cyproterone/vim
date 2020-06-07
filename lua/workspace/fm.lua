local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

registry.install("kyazdani42/nvim-tree.lua")
registry.install("kyazdani42/nvim-web-devicons")

local key = function ()

  local remap = function ()

    bindings.map.normal("R", ":LuaTreeRefresh<CR>")

  end
  registry.auto("FileType", remap, "LuaTree")

  bindings.map.normal("<Leader>i", ":LuaTreeToggle<CR>")

end
registry.defer(key)

