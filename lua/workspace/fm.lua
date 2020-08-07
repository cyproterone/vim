local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

registry.install("ms-jpq/chadtree", {["branch"] = "chad", ["do"] = ":UpdateRemotePlugins"})
local keybind = function ()

  vim.g.chadtree_settings = {logging_level = "INFO"}
  bindings.map.normal("<leader>v", "<cmd>CHADopen<cr>")

end
registry.defer(keybind)
