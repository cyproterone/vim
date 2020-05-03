local bindings = require "libs/bindings"
local registry = require "libs/registry"
local theme = require "libs/theme"


--#################### Highlight Region ####################

-- highlight copied region
registry.install("machakann/vim-highlightedyank")
local copy_highlight = function ()

  bindings.let("highlightedyank_highlight_duration", 500)

  theme.override{
    HighlightedyankRegion = {cterm = "reverse", gui = "reverse"}}

end
registry.defer(copy_highlight)


-- highlight colours
registry.install("norcalli/nvim-colorizer.lua")
local colour_highlight = function ()

  bindings.exec[[lua require("colorizer").setup()]]

end
registry.defer(colour_highlight)
