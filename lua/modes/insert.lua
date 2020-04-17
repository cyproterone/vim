local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Insert Region ####################

-- auto centering on entering insertion mode
local auto_centre = function ()

  bindings.auto{ group = "auto_centering",
                 events = { "InsertEnter" },
                 exec = "normal! zz", }

end
table.insert(defer, auto_centre)


return {
  plugins = plugins,
  defer = defer,
}
