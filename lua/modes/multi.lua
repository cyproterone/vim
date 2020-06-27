local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Multi-Mode Region ####################

-- add emacs key binds
local emacs = function ()

  -- ea
  bindings.map.insert("<c-a>",       "<c-o>^")
  bindings.map.insert("<c-x><c-a>",  "<c-a>")
  bindings.map.insert("<c-e>",       "pumvisible() ? '<c-e><End>' : '<End>'", {expr = true})

  -- ea
  bindings.map.command("<c-a>",      "<Home>", {silent = false})
  bindings.map.command("<c-x><c-a>", "<c-a>",  {silent = false})
  bindings.map.command("<c-e>",      "<End>",  {silent = false})

end
registry.defer(emacs)


local remap_keys = function ()

  -- delete dont copy
  bindings.map.normal("s",     [["_s]])
  bindings.map.normal("S",     [["_S]])
  bindings.map.normal("x",     [["_x]])
  bindings.map.normal("X",     [["_X]])

  bindings.map.nv("d", [["_d]])
  bindings.map.nv("D", [["_D]])

  bindings.map.nv("c", [["_c]])
  bindings.map.nv("C", [["_C]])

  -- leave cursor 1 behind
  bindings.map.nv("p", "gp")
  bindings.map.nv("P", "gP")

end
registry.defer(remap_keys)


local movement = function ()

  -- centre on up down
  bindings.map.nv("<c-u>", "<c-u>zz")
  bindings.map.nv("<c-d>", "<c-d>zz")
  bindings.map.nv("<c-f>", "<c-f>zz")
  bindings.map.nv("<c-b>", "<c-b>zz")


  -- centre on paragraph
  bindings.map.nv("{", "{zz")
  bindings.map.nv("}", "}zz")


end
registry.defer(movement)


local arrow = function ()

  bindings.map.nov("<m-left>",  "b")
  bindings.map.nov("<m-right>", "e")

  bindings.map.insert("<m-left>",  "<c-o>b")
  bindings.map.insert("<m-right>", "<c-o>e")

  bindings.map.command("<m-left>",  "<s-left>",  {silent = false})
  bindings.map.command("<m-right>", "<s-right>", {silent = false})

end
registry.defer(arrow)
