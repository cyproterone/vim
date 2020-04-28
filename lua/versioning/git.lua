local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Git Region ####################

-- gitgutter
table.insert(plugins, "airblade/vim-gitgutter")
local gutter = function ()

  --highlight line numbers
  bindings.let("gitgutter_highlight_linenrs", true)

end
table.insert(defer, gutter)


-- view git history
table.insert(plugins, "junegunn/gv.vim")


return {
  plugins = plugins,
  defer = defer,
}
