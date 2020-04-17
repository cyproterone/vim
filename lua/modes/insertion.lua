local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Insertion Mode Region ####################

local centering = function ()

  -- auto centering on entering insertion mode
  -- autocmd InsertEnter * norm zz

end
table.insert(defer, centering)


return {
  plugins = plugins,
  defer = defer,
}
