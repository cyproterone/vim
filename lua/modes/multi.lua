
local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Multi-Mode Region ####################

-- add eamcs keybinds in insert / command mode
table.insert(plugins, "tpope/vim-rsi")


local remap_keys = function ()

  -- delete dont copy
  bindings.map.normal("x", [["_x]])
  bindings.map.normal("X", [["_X]])

  bindings.map.nov("d", [["_d]])
  bindings.map.nov("D", [["_D]])

  bindings.map.nov("c", [["_c]])
  bindings.map.nov("C", [["_C]])

  -- normalize Y
  bindings.map.nov("Y", "y$")

end
table.insert(defer, remap_keys)


local movement = function ()

  -- centre on up down
  bindings.map.nov("<C-u>", "<C-u>zz")
  bindings.map.nov("<C-d>", "<C-d>zz")
  bindings.map.nov("<C-f>", "<C-f>zz")
  bindings.map.nov("<C-b>", "<C-b>zz")


  -- centre on paragraph
  bindings.map.nov("{", "{zz")
  bindings.map.nov("}", "}zz")

  -- centre on page
  bindings.map.nov("<S-Up>", "<Up>zz")
  bindings.map.nov("<S-Down>", "<Down>zz")
  bindings.map.insert("<S-Up>", "<Up><C-o>zz")
  bindings.map.insert("<S-Down>", "<Down><C-o>zz")

end
table.insert(defer, movement)


return {
  plugins = plugins,
  defer = defer,
}
