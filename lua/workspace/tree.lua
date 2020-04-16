require "libs/set"


tree = function ()

  local defer = {}
  local plugins = {}

  --#################### Tree Region ####################

  table.insert(
    plugins,
    "preservim/nerdtree")
  table.insert(
    plugins,
    "Xuyuanp/nerdtree-git-plugin")


  return {
    defer = defer,
    plugins = plugins
  }
end
