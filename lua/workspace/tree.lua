require "libs/set"


local plugins = {}
local defer = {}

--#################### Tree Region ####################

table.insert(plugins, "preservim/nerdtree")
table.insert(plugins, "Xuyuanp/nerdtree-git-plugin")


return {
  plugins = plugins,
  defer = defer,
}
