
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Multi-Mode Region ####################

-- add eamcs keybinds in insert / command mode
registry.install("tpope/vim-rsi")


local remap_keys = function ()

  -- delete dont copy
  bindings.map.normal("x", [["_x]])
  bindings.map.normal("X", [["_X]])

  bindings.map.nv("d", [["_d]])
  bindings.map.nv("D", [["_D]])

  bindings.map.nv("c", [["_c]])
  bindings.map.nv("C", [["_C]])

  -- normalize Y
  bindings.map.nv("Y", "y$")

end
registry.defer(remap_keys)


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
registry.defer(movement)
