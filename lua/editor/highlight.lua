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

  bindings.exec[[lua lv.colourizer={pcall(require, "colorizer")}]]
  local go, colourizer = unpack(lv.colourizer)
  lv.colourizer = nil
  if go then
    colourizer.setup()
  end

end
registry.defer(colour_highlight)
