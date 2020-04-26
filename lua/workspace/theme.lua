local bindings = require "libs/bindings"
local theme = require "libs/theme"

local plugins = {}
local defer = {}

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

end
table.insert(defer, intrinsic)


--#################### Cursors Region ####################

local cursors = function ()

  -- dont change cursor styling
  bindings.set("guicursor", "", [[=]])

  -- highlight cursor location
  bindings.set("cursorline")

end
table.insert(defer, cursors)


--#################### Powerline Region ####################

-- powerline
table.insert(plugins, "vim-airline/vim-airline")
table.insert(plugins, "vim-airline/vim-airline-themes")
local powerline = function ()

  -- airline apperance
  bindings.let("airline_powerline_fonts", true)
  bindings.let("airline_theme", "tomorrow")

end
table.insert(defer, powerline)


--#################### Colours Region ####################

-- colour theme::
table.insert(plugins, "NLKNguyen/papercolor-theme")
local colours = function ()

  bindings.set("background", "light")
  bindings.arbitrary("colorscheme PaperColor")

  bindings.let("PaperColor_Theme_Options",
               {theme = {default = {allow_bold = true,
                                    allow_italic = true}}})

end
table.insert(defer, colours)


-- iconpack
table.insert(plugins, "ryanoasis/vim-devicons")


return {
  plugins = plugins,
  defer = defer,
}
