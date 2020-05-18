
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

  -- leave cursor 1 behind
  bindings.map.nv("p", "gp")
  bindings.map.nv("P", "gP")

end
registry.defer(remap_keys)


local movement = function ()

  -- centre on up down
  bindings.map.nv("<C-u>", "<C-u>zz")
  bindings.map.nv("<C-d>", "<C-d>zz")
  bindings.map.nv("<C-f>", "<C-f>zz")
  bindings.map.nv("<C-b>", "<C-b>zz")


  -- centre on paragraph
  bindings.map.nv("{", "{zz")
  bindings.map.nv("}", "}zz")

  -- centre on page
  bindings.map.nv("<S-Up>", "<Up>zz")
  bindings.map.nv("<S-Down>", "<Down>zz")

end
registry.defer(movement)


local cua = function ()

  bindings.map.nic("<M-Left>", "<C-Left>")
  bindings.map.nic("<M-Right>", "<C-Right>")
  bindings.map.nic("<M-Up>", "<C-Up>")
  bindings.map.nic("<M-Down>", "<C-Down>")

end
registry.defer(cua)
