local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Highlight Region ####################

-- auto line num
-- registry.install("jeffkreeftmeijer/vim-numbertoggle")
local line_number = function ()

  -- show line count
  bindings.set("number")
  -- bindings.set("relativenumber")

end
registry.defer(line_number)


-- highlight copied region
registry.install("machakann/vim-highlightedyank")
local copy_highlight = function ()

  bindings.let("highlightedyank_highlight_duration", 500)

  -- theme.override{{"HighlightedyankRegion",
  --                 cterm = "reverse",
  --                 gui = "reverse"}}

end
registry.defer(copy_highlight)


-- highlight colours
registry.install("norcalli/nvim-colorizer.lua")
local colour_highlight = function ()

  bindings.exec[[lua require("colorizer").setup()]]

end
registry.defer(colour_highlight)
