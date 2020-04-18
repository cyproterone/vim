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


-- auto line num
table.insert(plugins, "jeffkreeftmeijer/vim-numbertoggle")
local line_number = function ()

  -- show line count
  bindings.set("number")
  bindings.set("relativenumber")

end
table.insert(defer, line_number)


-- highlight copied region
table.insert(plugins, "machakann/vim-highlightedyank")
local copy_highlight = function ()

  bindings.let("highlightedyank_highlight_duration", 1000)

end
table.insert(defer, copy_highlight)


-- focus on region
table.insert(plugins, "junegunn/limelight.vim")
local focus = function ()

  -- bindings.let

end


return {
  plugins = plugins,
  defer = defer,
}
