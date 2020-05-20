local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Multi-Mode Region ####################

-- add emacs key binds
local emacs = function ()

  -- ea
  bindings.map.insert("<C-a>",       "<C-o>^")
  bindings.map.insert("<C-x><C-a>",  "<C-a>")
  bindings.map.insert("<C-e>",       "pumvisible() ? '<C-e><End>' : '<End>'", {expr = true})

  -- ea
  bindings.map.command("<C-a>",      "<Home>", {silent = false})
  bindings.map.command("<C-x><C-a>", "<C-a>",  {silent = false})
  bindings.map.command("<C-e>",      "<End>",  {silent = false})

end
registry.defer(emacs)


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


end
registry.defer(movement)


local arrow = function ()

  bindings.map.niv("<M-Left>",  "<S-Left>")
  bindings.map.niv("<M-Right>", "<S-Right>")

  bindings.map.command("<M-Left>",  "<S-Left>",  {silent = false})
  bindings.map.command("<M-Right>", "<S-Right>", {silent = false})

end
registry.defer(arrow)
