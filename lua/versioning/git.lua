local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Git Region ####################

-- view git history
table.insert(plugins, "junegunn/gv.vim")

-- git in general
table.insert(plugins, "tpope/vim-fugitive")


return {
  plugins = plugins,
  defer = defer,
}
