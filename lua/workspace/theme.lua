local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Intrinsic Region ####################

local intrinsic = function ()

  -- use 256 colours
  bindings.set("termguicolors")

 -- show current mode
  bindings.set("showmode")

  -- show command history
  bindings.set("showcmd")

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

end
registry.defer(intrinsic)


--#################### Cursors Region ####################

local cursors = function ()

  -- dont change cursor styling
  bindings.set("guicursor", "", [[=]])

  -- highlight cursor location
  bindings.set("cursorline")

end
registry.defer(cursors)


--#################### Powerline Region ####################

-- powerline
registry.install("vim-airline/vim-airline")
registry.install("vim-airline/vim-airline-themes")
local powerline = function ()

  bindings.let("airline_powerline_fonts", true)
  bindings.let("airline_skip_empty_sections", true)


  bindings.let("airline#extensions#tabline#enabled", true)
  bindings.let("airline#extensions#tabline#show_tab_type", false)
  bindings.let("airline#extensions#tabline#show_tabs", true)
  bindings.let("airline#extensions#tabline#show_buffers", false)
  bindings.let("airline#extensions#tabline#show_splits", false)
  bindings.let("airline#extensions#tabline#show_tab_count", false)
  bindings.let("airline#extensions#tabline#tab_nr_type", 2)
  bindings.let("airline#extensions#tabline#overflow_marker", "…")
  bindings.let("airline#extensions#tabline#close_symbol", "×")
  bindings.let("airline#extensions#tabline#formatter", "unique_tail_improved")

end
registry.defer(powerline)


--#################### Colours Region ####################

-- colour theme::
registry.install("sainnhe/edge")
local colours = function ()

  -- background colour
  bindings.set("background", "light")

  -- theme
  bindings.exec("colorscheme edge")
  bindings.let("airline_theme", "edge")


  bindings.let("edge_style", "default")
  bindings.let("edge_transparent_background", true)
  bindings.let("edge_menu_selection_background", "purple")

end
registry.defer(colours)


-- iconpack
registry.install("ryanoasis/vim-devicons")


--#################### Colours Region ####################

-- active pane colours
-- registry.install("blueyed/vim-diminactive")
