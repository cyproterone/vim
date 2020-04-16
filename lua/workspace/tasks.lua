--#################### ############ ####################
--#################### Tasks Region ####################
--#################### ############ ####################
require "libs/set"


tasks = function ()

  local commands = {}
  local plugins = {}

  table.insert(plugins, "vim-scripts/vim-auto-save")


  return {
    commands = commands,
    plugins = plugins
  }
end
