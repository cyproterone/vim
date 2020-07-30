local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

registry.install("ms-jpq/chadtree", {["branch"] = "chad", ["do"] = ":UpdateRemotePlugins"})
local keybind = function ()

  bindings.map.normal("<leader>v", "<cmd>FMopen<cr>")

end
registry.defer(keybind)
