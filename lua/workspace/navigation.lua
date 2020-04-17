local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Intrinsic Region ####################

local wild = function ()

  -- ui for cmd auto complete
  bindings.set("wildmenu")

  -- auto complete menu priority
  bindings.set("wildmode", "longest,list,full")

  -- hide file history
  bindings.set("complete", "i", [[-=]])

  -- more history
  bindings.set("history", 10000)

end
table.insert(defer, wild)


--#################### FZF Region ####################

-- fzf
table.insert(plugins, "junegunn/fzf")
table.insert(plugins, "yuki-ycino/fzf-preview.vim")
local fzf = function ()


end
table.insert(defer, fzf)


return {
  plugins = plugins,
  defer = defer,
}
