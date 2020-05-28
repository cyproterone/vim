local bindings = require "libs/bindings"
local registry = require "libs/registry"
local theme = require "libs/theme"


--#################### Highlight Region ####################

-- highlight copied region
local copy_highlight = function ()

  local highlighter = require "vim/highlight"

  local highlight_yank = function ()
    highlighter.on_yank("IncSearch", 500, vim.v.event)
  end
  registry.auto("TextYankPost", highlight_yank)

end
registry.defer(copy_highlight)


-- -- highlight colours
-- registry.install("norcalli/nvim-colorizer.lua")
-- local colour_highlight = function ()

--   bindings.exec[[lua require("colorizer").setup()]]

-- end
-- registry.defer(colour_highlight)
