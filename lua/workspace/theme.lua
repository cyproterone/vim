local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Intrinsic Region ####################

local intrinsic = function ()

  -- use 256 colours
  bindings.set("termguicolors")

  -- highlight cursor location
  bindings.set("cursorline")

  -- show current mode
  bindings.set("showmode")

  -- show command history
  bindings.set("showcmd")

  -- always show status line
  bindings.set("laststatus", 2)

end
table.insert(defer, intrinsic)


--#################### Cursors Region ####################

-- stop changing cursor shape
local cursors = function ()

end
table.insert(defer, cursors)


--#################### Powerline Region ####################

-- powerline
table.insert(plugins, "vim-airline/vim-airline")
local powerline = function ()

  -- airline apperance
  bindings.let("airline_powerline_fonts", 1)
  bindings.let("airline_theme", [['edge']])

end
table.insert(defer, powerline)


--#################### Colours Region ####################

-- colour theme::
table.insert(plugins, "sainnhe/edge")
local colours = function ()

  bindings.set("background", "light")
  bindings.arbitrary("colorscheme edge")

  bindings.let("edge_style", [['neon']])
  bindings.let("edge_transparent_background", 1)
  bindings.let("edge_menu_selection_background", [['purple']])
  bindings.let("edge_enable_italic", 0)

end
table.insert(defer, colours)


-- iconpack
table.insert(plugins, "ryanoasis/vim-devicons")


return {
  plugins = plugins,
  defer = defer,
}
