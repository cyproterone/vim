bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Highlight Region ####################

-- syntax highlight
local syntax_highlight = function ()
  bindings.arbitrary("filetype plugin indent on")
  bindings.arbitrary("syntax on")
end
table.insert(defer, syntax_highlight)


-- show line count
local line_number = function ()
  bindings.set("number")
end
table.insert(defer, line_number)


return {
  plugins = plugins,
  defer = defer,
}
