local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Highlight Region ####################

-- syntax highlight
local syntax_highlight = function ()

  bindings.arbitrary("filetype plugin indent on")
  bindings.arbitrary("syntax on")

  -- show matching parens
  bindings.set("showmatch")
  -- match paren highlight time
  bindings.set("matchtime", 5)

end
table.insert(defer, syntax_highlight)


-- show line count
local line_number = function ()

  bindings.set("number")
  bindings.set("relativenumber")
  
end
table.insert(defer, line_number)


-- focus on region
table.insert(plugins, "junegunn/limelight.vim")
local focus = function ()

  -- bindings.let

end


return {
  plugins = plugins,
  defer = defer,
}
