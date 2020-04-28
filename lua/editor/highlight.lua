local bindings = require "libs/bindings"
local theme = require "libs/theme"


local plugins = {}
local defer = {}

--#################### Highlight Region ####################

-- auto line num
-- table.insert(plugins, "jeffkreeftmeijer/vim-numbertoggle")
local line_number = function ()

  -- show line count
  bindings.set("number")
  -- bindings.set("relativenumber")

end
table.insert(defer, line_number)


-- highlight copied region
table.insert(plugins, "machakann/vim-highlightedyank")
local copy_highlight = function ()

  bindings.let("highlightedyank_highlight_duration", 500)

  theme.override{{"HighlightedyankRegion",
                  cterm = "reverse",
                  gui = "reverse"}}

end
table.insert(defer, copy_highlight)


-- highlight colours
table.insert(plugins, "norcalli/nvim-colorizer.lua")
local colour_highlight = function ()

  bindings.arbitrary[[lua require("colorizer").setup()]]

end
table.insert(defer, colour_highlight)


return {
  plugins = plugins,
  defer = defer,
}
