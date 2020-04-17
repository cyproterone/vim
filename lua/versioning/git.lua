local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Git Region ####################

-- gitgutter
table.insert(plugins, "airblade/vim-gitgutter")
local gutter = function ()

  --highlight line numbers
  bindings.let("gitgutter_highlight_linenrs", 1)

end
table.insert(defer, gutter)


-- view git history
table.insert(plugins, "junegunn/gv.vim")


-- git porcelain
table.insert(plugins, "tpope/vim-fugitive")


return {
  plugins = plugins,
  defer = defer,
}
