
local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Multi-Mode Region ####################

-- add eamcs keybinds in insert / command mode
table.insert(plugins, "tpope/vim-rsi")


local remap_keys = function ()

  -- delete dont copy
  bindings.map.normal("d", [["_d]])
  bindings.map.normal("D", [["_D]])

  bindings.map.normal("c", [["_c]])
  bindings.map.normal("C", [["_C]])

  bindings.map.normal("x", [["_x]])
  bindings.map.normal("X", [["_X]])

  bindings.map.visual("d", [["_d]])
  bindings.map.visual("D", [["_D]])

  bindings.map.visual("c", [["_c]])
  bindings.map.visual("C", [["_C]])


  -- normalize Y
  bindings.map.normal("Y", "y$")
  bindings.map.visual("Y", "y$")

end
table.insert(defer, remap_keys)


local movement = function ()

  -- centre on search result
  bindings.map.normal("n", "nzz")
  bindings.map.normal("N", "Nzz")


  -- centre on up down
  bindings.map.normal("j", "jzz")
  bindings.map.normal("k", "kzz")
  bindings.map.normal("<Up>", "<Up>zz")
  bindings.map.normal("<Down>", "<Down>zz")


  -- centre on paragraph
  bindings.map.normal("{", "{zz")
  bindings.map.normal("}", "}zz")

end
table.insert(defer, movement)


return {
  plugins = plugins,
  defer = defer,
}
