local bindings = require "libs/bindings"
local registry = require "libs/registry"
local theme = require "libs/theme"


--#################### Intrinsic Region ####################

local intrinsic = function ()

  -- use 256 colours
  bindings.set("termguicolors")

  -- always show status line
  bindings.set("laststatus", 2)

  -- always show issues column
  bindings.set("signcolumn", "yes")

  -- show show eob lines
  bindings.set("fillchars", [[eob:\ ]])

  -- always show tabline
  bindings.set("showtabline", 2)

  -- show line count
  bindings.set("number")

  -- show cursor
  bindings.set("cursorline")

end
registry.defer(intrinsic)


--#################### Cursors Region ####################

local cursors = function ()

  -- dont change cursor styling
  bindings.set("guicursor", "", [[=]])

  -- change cursor line colour
  local enter = function ()
    theme.highlight{CursorLine = {guibg = "#f2d9fa"}}
  end

  local leave = function ()
    theme.highlight{CursorLine = {guibg = "#f1f4f6"}}
  end

  registry.auto("InsertEnter", enter)
  registry.auto("InsertLeave", leave)

end
registry.defer(cursors)


--#################### Colours Region ####################

-- colour theme::
registry.install("sainnhe/edge")
local colours = function ()

  -- background colour
  bindings.set("background", "light")

  -- theme
  bindings.exec("colorscheme edge")


  vim.g.edge_style = "neon"
  vim.g.edge_menu_selection_background = "purple"

end
registry.defer(colours)


-- powerline
registry.install("itchyny/lightline.vim")
local powerline = function ()

  vim.g.lightline = {colorscheme = "edge"}

end
registry.defer(powerline)
