local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Format Region ####################

local sort = function ()

  lua_sort_lines = function (type)
    if not type then
      return
    elseif type == "line" then
      return
    end
  end

  bindings.map.normal("gs", ":set opfunc=v:lua.lua_sort_lines<CR>g@")
  bindings.map.visual("gs", "<Esc>:v:lua.lua_sort_lines()<CR>")

end
registry.defer(sort)


-- prettiers
registry.install("sbdchd/neoformat")
local prettier = function ()

  -- remove default formatter
  bindings.map.normal("gq", ":Neoformat<CR>")
  bindings.map.normal("gQ", ":Neoformat<CR>")

end
registry.defer(prettier)

