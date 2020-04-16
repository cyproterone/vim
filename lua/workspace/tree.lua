require "libs/set"


tree = function ()

  local commands = {}
  local plugins = {}

  --#################### Tree Region ####################

  table.insert(plugins,
               "preservim/nerdtree")
  table.insert(plugins,
               "Xuyuanp/nerdtree-git-plugin")


  return {
    commands = commands,
    plugins = plugins
  }
end
