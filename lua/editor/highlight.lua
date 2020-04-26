local bindings = require "libs/bindings"
local theme = require "libs/theme"


local plugins = {}
local defer = {}

--#################### Highlight Region ####################

-- syntax highlight
local syntax_highlight = function ()

  bindings.arbitrary("filetype plugin indent on")
  bindings.arbitrary("syntax on")

end
table.insert(defer, syntax_highlight)


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

  theme.override{{ "HighlightedyankRegion",
                   cterm = "reverse",
                   gui = "reverse" }}

end
table.insert(defer, copy_highlight)


-- highlight undo
table.insert(plugins, "mbbill/undotree")
local undo_tree = function ()


end
table.insert(defer, undo_tree)


-- focus on region TODO: this needs LSP
table.insert(plugins, "junegunn/limelight.vim")
local focus = function ()

  -- bindings.map.normal("<Leader>i", ":Limelight<CR>")

  bindings.let("limelight_conceal_ctermfg", "gray")
  bindings.let("limelight_conceal_guifg", "DarkGray")

end
table.insert(defer, focus)


return {
  plugins = plugins,
  defer = defer,
}
