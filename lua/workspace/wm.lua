local bindings = require "libs/bindings"


local defer = {}
local plugins = {}

--#################### Intrinsic Region ####################

-- modern split direction
local modern_split = function ()
  bindings.set("splitright")
  bindings.set("splitbelow")
end
table.insert(defer, modern_split)


--#################### WM Region ####################

-- swap windows
table.insert(plugins, "wesQ3/vim-windowswap")


-- resize active window
table.insert(plugins, "camspiers/lens.vim")


return {
  plugins = plugins,
  defer = defer,
}
