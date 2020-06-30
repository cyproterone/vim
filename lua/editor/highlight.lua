local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Highlight Region ####################

-- highlight copied region
local copy_highlight = function ()

  local highlighter = require "vim/highlight"

  local highlight_yank = function ()
    highlighter.on_yank()
  end
  registry.auto("TextYankPost", highlight_yank)

end
registry.defer(copy_highlight)


-- highlight colours
registry.install("norcalli/nvim-colorizer.lua")
local colour_highlight = function ()

  local setup = function (kill)
    kill()
    require("colorizer").setup()
  end
  registry.auto("VimEnter", setup)

end
registry.defer(colour_highlight)
