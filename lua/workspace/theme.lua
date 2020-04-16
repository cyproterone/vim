local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Intrinsic Region ####################

local intrinsic = function ()

  -- use 256 colours
  bindings.set("termguicolors")

  -- highlight cursor location
  bindings.set("cursorline")

  -- show command history
  bindings.set("showcmd")

  -- always show status line
  bindings.set("laststatus", 2)

end
table.insert(defer, intrinsic)


--#################### Powerline Region ####################

-- powerline
table.insert(plugins, "vim-airline/vim-airline")
table.insert(plugins, "vim-airline/vim-airline-themes")

local powerline = function ()

  bindings.let("airline_theme", "'tomorrow'")
  bindings.let("airline_powerline_fonts", 1)

end
table.insert(defer, powerline)


--#################### Colours Region ####################

-- colour theme
table.insert(plugins, "junegunn/seoul256.vim")

local colours = function ()

  bindings.arbitrary("colorscheme seoul256-light")

end
table.insert(defer, colours)


-- iconpack
table.insert(plugins, "ryanoasis/vim-devicons")


return {
  plugins = plugins,
  defer = defer,
}
